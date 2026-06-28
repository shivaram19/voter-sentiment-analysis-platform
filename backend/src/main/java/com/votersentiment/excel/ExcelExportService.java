package com.votersentiment.excel;

import com.fasterxml.jackson.databind.JsonNode;
import com.votersentiment.excel.logs.ExportLog;
import com.votersentiment.excel.logs.ExportStatus;
import com.votersentiment.excel.logs.ExportType;
import com.votersentiment.questionnaire.Question;
import com.votersentiment.questionnaire.QuestionGroup;
import com.votersentiment.questionnaire.QuestionType;
import com.votersentiment.questionnaire.Questionnaire;
import com.votersentiment.questionnaire.repo.QuestionGroupRepository;
import com.votersentiment.questionnaire.repo.QuestionRepository;
import com.votersentiment.survey.Response;
import com.votersentiment.survey.Survey;
import com.votersentiment.survey.repo.ResponseRepository;
import com.votersentiment.survey.repo.SurveyRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class ExcelExportService {

    @Inject
    QuestionGroupRepository questionGroupRepository;

    @Inject
    QuestionRepository questionRepository;

    @Inject
    SurveyRepository surveyRepository;

    @Inject
    ResponseRepository responseRepository;

    private static final List<String> TEMPLATE_HEADERS = List.of(
            "question_id", "group_name", "question_text_en", "question_text_hi", "question_text_ta",
            "question_type", "options", "allow_multiple", "allow_voice", "required", "gps_capture",
            "skip_logic", "display_order"
    );

    @Transactional
    public byte[] exportTemplate(UUID questionnaireId) throws IOException {
        List<QuestionGroup> groups = questionGroupRepository.findByQuestionnaire(questionnaireId);
        List<Question> questions = questionRepository.findByQuestionnaire(questionnaireId);
        Map<UUID, List<Question>> questionsByGroup = questions.stream()
                .collect(Collectors.groupingBy(q -> q.getQuestionGroup().getId()));

        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            for (QuestionGroup group : groups) {
                Sheet sheet = workbook.createSheet(sanitizeSheetName(group.getGroupName()));
                createHeaderRow(sheet, TEMPLATE_HEADERS);
                List<Question> groupQuestions = questionsByGroup.getOrDefault(group.getId(), List.of());
                int rowIdx = 1;
                for (Question q : groupQuestions) {
                    Row row = sheet.createRow(rowIdx++);
                    row.createCell(0).setCellValue(q.getQuestionIdentifier());
                    row.createCell(1).setCellValue(group.getGroupName());
                    row.createCell(2).setCellValue(text(q.getQuestionText(), "en"));
                    row.createCell(3).setCellValue(text(q.getQuestionText(), "hi"));
                    row.createCell(4).setCellValue(text(q.getQuestionText(), "ta"));
                    row.createCell(5).setCellValue(q.getQuestionType().name());
                    row.createCell(6).setCellValue(q.getOptions() != null ? String.join("|", q.getOptions()) : "");
                    row.createCell(7).setCellValue(q.isAllowMultiple());
                    row.createCell(8).setCellValue(q.isAllowVoice());
                    row.createCell(9).setCellValue(q.isRequired());
                    row.createCell(10).setCellValue(q.isCaptureGps());
                    row.createCell(11).setCellValue(q.getSkipLogic() != null ? q.getSkipLogic().toString() : "");
                    row.createCell(12).setCellValue(q.getDisplayOrder());
                }
            }
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            workbook.write(out);
            logExport(questionnaireId, ExportType.TEMPLATE, "template.xlsx", ExportStatus.SUCCESS);
            return out.toByteArray();
        } catch (IOException e) {
            logExportFailure(questionnaireId, ExportType.TEMPLATE, "template.xlsx", e.getMessage());
            throw e;
        }
    }

    @Transactional
    public byte[] exportResponses(UUID questionnaireId) throws IOException {
        List<Survey> surveys = surveyRepository.findByQuestionnaire(questionnaireId, 0, Integer.MAX_VALUE);
        List<Response> responses = responseRepository.findByQuestionnaire(questionnaireId);
        Map<UUID, List<Response>> responsesBySurvey = responses.stream()
                .collect(Collectors.groupingBy(Response::getSurveyId));

        try (SXSSFWorkbook workbook = new SXSSFWorkbook(100)) {
            Sheet sheet = workbook.createSheet("Responses");
            String[] headers = {"survey_id", "client_survey_id", "surveyor_id", "submitted_at", "language",
                    "state", "district", "taluka", "village", "question_id", "response_type", "response_value"};
            createHeaderRow(sheet, headers);

            int rowIdx = 1;
            for (Survey survey : surveys) {
                List<Response> surveyResponses = responsesBySurvey.getOrDefault(survey.getId(), List.of());
                for (Response response : surveyResponses) {
                    Row row = sheet.createRow(rowIdx++);
                    row.createCell(0).setCellValue(survey.getId().toString());
                    row.createCell(1).setCellValue(survey.getClientSurveyId().toString());
                    row.createCell(2).setCellValue(survey.getSurveyorId().toString());
                    row.createCell(3).setCellValue(survey.getSubmittedAt() != null ? survey.getSubmittedAt().toString() : "");
                    row.createCell(4).setCellValue(survey.getLanguageUsed() != null ? survey.getLanguageUsed() : "");
                    row.createCell(5).setCellValue(survey.getState() != null ? survey.getState() : "");
                    row.createCell(6).setCellValue(survey.getDistrict() != null ? survey.getDistrict() : "");
                    row.createCell(7).setCellValue(survey.getTaluka() != null ? survey.getTaluka() : "");
                    row.createCell(8).setCellValue(survey.getVillage() != null ? survey.getVillage() : "");
                    row.createCell(9).setCellValue(response.getQuestionId().toString());
                    row.createCell(10).setCellValue(response.getResponseType().name());
                    row.createCell(11).setCellValue(jsonToString(response.getResponseValue()));
                }
            }
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            workbook.write(out);
            workbook.dispose();
            logExport(questionnaireId, ExportType.RESPONSES, "responses.xlsx", ExportStatus.SUCCESS);
            return out.toByteArray();
        } catch (IOException e) {
            logExportFailure(questionnaireId, ExportType.RESPONSES, "responses.xlsx", e.getMessage());
            throw e;
        }
    }

    private void createHeaderRow(Sheet sheet, List<String> headers) {
        Row row = sheet.createRow(0);
        for (int i = 0; i < headers.size(); i++) {
            Cell cell = row.createCell(i);
            cell.setCellValue(headers.get(i));
        }
    }

    private void createHeaderRow(Sheet sheet, String[] headers) {
        Row row = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = row.createCell(i);
            cell.setCellValue(headers[i]);
        }
    }

    private String text(Map<String, String> map, String lang) {
        return map != null ? map.getOrDefault(lang, "") : "";
    }

    private String jsonToString(JsonNode node) {
        if (node == null || node.isNull()) return "";
        if (node.isTextual()) return node.asText();
        return node.toString();
    }

    private String sanitizeSheetName(String name) {
        if (name == null) return "Sheet";
        String sanitized = name.replaceAll("[\\\\/*\\[\\]:?]", "_");
        return sanitized.length() > 31 ? sanitized.substring(0, 31) : sanitized;
    }

    private void logExport(UUID questionnaireId, ExportType type, String filename, ExportStatus status) {
        Questionnaire questionnaire = Questionnaire.findById(questionnaireId);
        ExportLog log = ExportLog.builder()
                .questionnaire(questionnaire)
                .exportType(type)
                .filename(filename)
                .status(status)
                .build();
        log.persist();
    }

    @Transactional(Transactional.TxType.REQUIRES_NEW)
    public void logExportFailure(UUID questionnaireId, ExportType type, String filename, String errorMessage) {
        Questionnaire questionnaire = Questionnaire.findById(questionnaireId);
        ExportLog log = ExportLog.builder()
                .questionnaire(questionnaire)
                .exportType(type)
                .filename(filename)
                .status(ExportStatus.FAILED)
                .build();
        log.persist();
    }
}
