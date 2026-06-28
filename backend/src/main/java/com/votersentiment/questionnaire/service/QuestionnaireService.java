package com.votersentiment.questionnaire.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.votersentiment.common.PagedResponse;
import com.votersentiment.excel.dto.ParsedQuestionDto;
import com.votersentiment.excel.dto.ParsedSheetDto;
import com.votersentiment.questionnaire.Question;
import com.votersentiment.questionnaire.QuestionGroup;
import com.votersentiment.questionnaire.Questionnaire;
import com.votersentiment.questionnaire.dto.QuestionDto;
import com.votersentiment.questionnaire.dto.QuestionGroupDto;
import com.votersentiment.questionnaire.dto.QuestionnaireDto;
import com.votersentiment.questionnaire.dto.QuestionnaireSummaryDto;
import com.votersentiment.questionnaire.repo.QuestionGroupRepository;
import com.votersentiment.questionnaire.repo.QuestionRepository;
import com.votersentiment.questionnaire.repo.QuestionnaireRepository;
import com.votersentiment.user.User;
import com.votersentiment.user.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.BadRequestException;
import jakarta.ws.rs.NotFoundException;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class QuestionnaireService {

    @Inject
    QuestionnaireRepository questionnaireRepository;

    @Inject
    QuestionGroupRepository questionGroupRepository;

    @Inject
    QuestionRepository questionRepository;

    @Inject
    UserRepository userRepository;

    @Transactional
    public QuestionnaireDto createFromDto(UUID creatorId, QuestionnaireDto dto) {
        User creator = userRepository.findActiveById(creatorId)
                .orElseThrow(() -> new NotFoundException("Creator not found"));
        Questionnaire questionnaire = mapToEntity(dto, creator);
        questionnaireRepository.persist(questionnaire);
        persistGroups(questionnaire, dto.getGroups());
        return toFullDto(questionnaire);
    }

    @Transactional
    public QuestionnaireDto createFromParsed(UUID creatorId, String title, String description,
                                             List<ParsedSheetDto> sheets) {
        User creator = userRepository.findActiveById(creatorId)
                .orElseThrow(() -> new NotFoundException("Creator not found"));
        Questionnaire questionnaire = Questionnaire.builder()
                .title(title != null ? title : "Untitled")
                .description(description)
                .createdBy(creator)
                .isActive(false)
                .languageSupport(Map.of("en", "true"))
                .build();
        questionnaireRepository.persist(questionnaire);

        List<QuestionGroupDto> groupDtos = new ArrayList<>();
        for (ParsedSheetDto sheet : sheets) {
            QuestionGroup group = QuestionGroup.builder()
                    .questionnaire(questionnaire)
                    .groupName(sheet.getGroupName())
                    .sheetOrder(sheet.getSheetOrder())
                    .isOptional(sheet.isOptional())
                    .build();
            questionGroupRepository.persist(group);

            List<QuestionDto> questionDtos = new ArrayList<>();
            for (ParsedQuestionDto pq : sheet.getQuestions()) {
                Question question = Question.builder()
                        .questionGroup(group)
                        .questionIdentifier(pq.getQuestionIdentifier())
                        .questionText(pq.getQuestionText())
                        .questionType(pq.getQuestionType())
                        .options(pq.getOptions())
                        .allowMultiple(pq.isAllowMultiple())
                        .allowVoice(pq.isAllowVoice())
                        .isRequired(pq.isRequired())
                        .captureGps(pq.isGpsCapture())
                        .skipLogic(pq.getSkipLogic())
                        .displayOrder(pq.getDisplayOrder())
                        .build();
                questionRepository.persist(question);
                questionDtos.add(toQuestionDto(question));
            }
            groupDtos.add(QuestionGroupDto.builder()
                    .id(group.getId())
                    .groupName(group.getGroupName())
                    .sheetOrder(group.getSheetOrder())
                    .isOptional(group.isOptional())
                    .questions(questionDtos)
                    .build());
        }

        return QuestionnaireDto.builder()
                .id(questionnaire.getId())
                .title(questionnaire.getTitle())
                .description(questionnaire.getDescription())
                .createdById(creator.getId())
                .isActive(questionnaire.isActive())
                .languageSupport(questionnaire.getLanguageSupport())
                .groups(groupDtos)
                .createdAt(questionnaire.getCreatedAt())
                .updatedAt(questionnaire.getUpdatedAt())
                .build();
    }

    @Transactional
    public QuestionnaireDto update(UUID id, QuestionnaireDto dto) {
        Questionnaire q = questionnaireRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("Questionnaire not found"));
        q.setTitle(dto.getTitle());
        q.setDescription(dto.getDescription());
        q.setLanguageSupport(dto.getLanguageSupport());
        // TODO: support updating groups/questions if provided
        return toFullDto(q);
    }

    @Transactional
    public QuestionnaireDto activate(UUID id) {
        Questionnaire q = questionnaireRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("Questionnaire not found"));
        q.setActive(true);
        return toSummaryDto(q);
    }

    @Transactional
    public QuestionnaireDto deactivate(UUID id) {
        Questionnaire q = questionnaireRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("Questionnaire not found"));
        q.setActive(false);
        return toSummaryDto(q);
    }

    @Transactional
    public void delete(UUID id) {
        Questionnaire q = questionnaireRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("Questionnaire not found"));
        q.setDeletedAt(Instant.now());
    }

    public QuestionnaireDto getById(UUID id) {
        Questionnaire q = questionnaireRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("Questionnaire not found"));
        return toFullDto(q);
    }

    public PagedResponse<QuestionnaireSummaryDto> list(int page, int size) {
        long total = questionnaireRepository.countActive();
        List<Questionnaire> items = questionnaireRepository.listActive(page, size, "updatedAt");
        List<QuestionnaireSummaryDto> dtos = items.stream()
                .map(this::toSummaryDto)
                .toList();
        return PagedResponse.of(dtos, page, size, total);
    }

    public QuestionnaireDto getFullForSurveyor(UUID id) {
        return getById(id);
    }

    private Questionnaire mapToEntity(QuestionnaireDto dto, User creator) {
        return Questionnaire.builder()
                .title(dto.getTitle())
                .description(dto.getDescription())
                .createdBy(creator)
                .isActive(dto.isActive())
                .languageSupport(dto.getLanguageSupport())
                .build();
    }

    private void persistGroups(Questionnaire questionnaire, List<QuestionGroupDto> groups) {
        if (groups == null) return;
        for (QuestionGroupDto gd : groups) {
            QuestionGroup group = QuestionGroup.builder()
                    .questionnaire(questionnaire)
                    .groupName(gd.getGroupName())
                    .sheetOrder(gd.getSheetOrder())
                    .isOptional(gd.isOptional())
                    .build();
            questionGroupRepository.persist(group);
            persistQuestions(group, gd.getQuestions());
        }
    }

    private void persistQuestions(QuestionGroup group, List<QuestionDto> questions) {
        if (questions == null) return;
        for (QuestionDto qd : questions) {
            Question question = Question.builder()
                    .questionGroup(group)
                    .questionIdentifier(qd.getQuestionIdentifier())
                    .questionText(qd.getQuestionText())
                    .questionType(qd.getQuestionType())
                    .options(qd.getOptions())
                    .allowMultiple(qd.isAllowMultiple())
                    .allowVoice(qd.isAllowVoice())
                    .isRequired(qd.isRequired())
                    .captureGps(qd.isCaptureGps())
                    .skipLogic(qd.getSkipLogic())
                    .displayOrder(qd.getDisplayOrder())
                    .build();
            questionRepository.persist(question);
        }
    }

    private QuestionnaireDto toFullDto(Questionnaire q) {
        List<QuestionGroup> groups = questionGroupRepository.findByQuestionnaire(q.getId());
        List<QuestionGroupDto> groupDtos = groups.stream().map(g -> {
            List<Question> questions = questionRepository.findByQuestionGroup(g.getId());
            return QuestionGroupDto.builder()
                    .id(g.getId())
                    .groupName(g.getGroupName())
                    .sheetOrder(g.getSheetOrder())
                    .isOptional(g.isOptional())
                    .questions(questions.stream().map(this::toQuestionDto).toList())
                    .build();
        }).toList();

        return QuestionnaireDto.builder()
                .id(q.getId())
                .title(q.getTitle())
                .description(q.getDescription())
                .createdById(q.getCreatedBy().getId())
                .isActive(q.isActive())
                .languageSupport(q.getLanguageSupport())
                .groups(groupDtos)
                .createdAt(q.getCreatedAt())
                .updatedAt(q.getUpdatedAt())
                .build();
    }

    private QuestionnaireSummaryDto toSummaryDto(Questionnaire q) {
        return QuestionnaireSummaryDto.builder()
                .id(q.getId())
                .title(q.getTitle())
                .description(q.getDescription())
                .createdById(q.getCreatedBy().getId())
                .isActive(q.isActive())
                .languageSupport(q.getLanguageSupport())
                .createdAt(q.getCreatedAt())
                .updatedAt(q.getUpdatedAt())
                .build();
    }

    private QuestionDto toQuestionDto(Question q) {
        return QuestionDto.builder()
                .id(q.getId())
                .questionIdentifier(q.getQuestionIdentifier())
                .questionText(q.getQuestionText())
                .questionType(q.getQuestionType())
                .options(q.getOptions())
                .allowMultiple(q.isAllowMultiple())
                .allowVoice(q.isAllowVoice())
                .isRequired(q.isRequired())
                .captureGps(q.isCaptureGps())
                .skipLogic(q.getSkipLogic())
                .displayOrder(q.getDisplayOrder())
                .build();
    }
}
