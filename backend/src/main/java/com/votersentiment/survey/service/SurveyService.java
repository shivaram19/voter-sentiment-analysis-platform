package com.votersentiment.survey.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.votersentiment.survey.*;
import com.votersentiment.survey.dto.*;
import com.votersentiment.survey.repo.ResponseRepository;
import com.votersentiment.survey.repo.SurveyRepository;
import com.votersentiment.survey.repo.SyncLogRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.NotFoundException;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class SurveyService {

    @Inject
    SurveyRepository surveyRepository;

    @Inject
    ResponseRepository responseRepository;

    @Inject
    SyncLogRepository syncLogRepository;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Transactional
    public SurveyDto startSurvey(UUID surveyorId, StartSurveyRequest request) {
        Survey existing = surveyRepository.findByClientSurveyId(surveyorId, request.getClientSurveyId())
                .orElse(null);
        if (existing != null) {
            return toDto(existing);
        }

        Survey survey = buildSurvey(surveyorId, request);
        survey.setSyncStatus(SyncStatus.PENDING);
        surveyRepository.persist(survey);
        return toDto(survey);
    }

    @Transactional
    public SurveyDto addResponse(UUID surveyId, ResponseRequest request) {
        Survey survey = surveyRepository.findById(surveyId);
        if (survey == null) {
            throw new NotFoundException("Survey not found");
        }
        Response response = buildResponse(surveyId, request);
        responseRepository.persist(response);
        return toDto(survey);
    }

    @Transactional
    public SurveyDto completeSurvey(UUID surveyId) {
        Survey survey = surveyRepository.findById(surveyId);
        if (survey == null) {
            throw new NotFoundException("Survey not found");
        }
        survey.setSubmittedAt(Instant.now());
        survey.setSyncStatus(SyncStatus.SYNCED);
        logSync(survey.getId(), SyncStatus.SYNCED, null);
        return toDto(survey);
    }

    @Transactional
    public List<BatchSyncResultItem> batchSync(UUID surveyorId, BatchSyncRequest request) {
        List<BatchSyncResultItem> results = new ArrayList<>();
        for (BatchSyncItem item : request.getSurveys()) {
            results.add(syncSingle(surveyorId, item));
        }
        return results;
    }

    private BatchSyncResultItem syncSingle(UUID surveyorId, BatchSyncItem item) {
        try {
            Survey survey = surveyRepository.findByClientSurveyId(surveyorId, item.getClientSurveyId())
                    .orElse(null);
            boolean isNew = false;
            if (survey == null) {
                survey = buildSurvey(surveyorId, item);
                isNew = true;
            } else if (survey.getSyncStatus() == SyncStatus.SYNCED) {
                return BatchSyncResultItem.builder()
                        .clientSurveyId(item.getClientSurveyId())
                        .serverSurveyId(survey.getId())
                        .status("SYNCED")
                        .build();
            } else {
                updateSurvey(survey, item);
            }

            // Replace responses for idempotent replay
            responseRepository.deleteBySurvey(survey.getId());
            if (item.getResponses() != null) {
                for (ResponseRequest r : item.getResponses()) {
                    responseRepository.persist(buildResponse(survey.getId(), r));
                }
            }

            survey.setSyncStatus(SyncStatus.SYNCED);
            survey.setSubmittedAt(item.getSubmittedAtEpochMillis() != null
                    ? Instant.ofEpochMilli(item.getSubmittedAtEpochMillis())
                    : Instant.now());
            if (isNew) {
                surveyRepository.persist(survey);
            } else {
                surveyRepository.persistAndFlush(survey);
            }
            logSync(survey.getId(), SyncStatus.SYNCED, null);

            return BatchSyncResultItem.builder()
                    .clientSurveyId(item.getClientSurveyId())
                    .serverSurveyId(survey.getId())
                    .status("SYNCED")
                    .build();
        } catch (Exception e) {
            // Try to record a failed survey log if we can find/create it
            try {
                Survey survey = surveyRepository.findByClientSurveyId(surveyorId, item.getClientSurveyId())
                        .orElse(null);
                if (survey != null) {
                    survey.setSyncStatus(SyncStatus.FAILED);
                    surveyRepository.persist(survey);
                    logSync(survey.getId(), SyncStatus.FAILED, truncate(e.getMessage()));
                }
            } catch (Exception ignored) {
            }
            return BatchSyncResultItem.builder()
                    .clientSurveyId(item.getClientSurveyId())
                    .serverSurveyId(null)
                    .status("FAILED")
                    .errorMessage(truncate(e.getMessage()))
                    .build();
        }
    }

    public SurveyDto getSurvey(UUID surveyId) {
        Survey survey = surveyRepository.findById(surveyId);
        if (survey == null) {
            throw new NotFoundException("Survey not found");
        }
        return toDto(survey);
    }

    private Survey buildSurvey(UUID surveyorId, StartSurveyRequest request) {
        return Survey.builder()
                .questionnaireId(request.getQuestionnaireId())
                .surveyorId(surveyorId)
                .clientSurveyId(request.getClientSurveyId())
                .languageUsed(request.getLanguageUsed())
                .respondentName(request.getRespondentName())
                .respondentAge(request.getRespondentAge())
                .respondentGender(request.getRespondentGender())
                .state(request.getState())
                .district(request.getDistrict())
                .taluka(request.getTaluka())
                .village(request.getVillage())
                .gpsLatitude(request.getGpsLatitude())
                .gpsLongitude(request.getGpsLongitude())
                .gpsAccuracy(request.getGpsAccuracy())
                .startedAt(Instant.now())
                .build();
    }

    private Survey buildSurvey(UUID surveyorId, BatchSyncItem item) {
        return Survey.builder()
                .questionnaireId(item.getQuestionnaireId())
                .surveyorId(surveyorId)
                .clientSurveyId(item.getClientSurveyId())
                .languageUsed(item.getLanguageUsed())
                .respondentName(item.getRespondentName())
                .respondentAge(item.getRespondentAge())
                .respondentGender(item.getRespondentGender())
                .state(item.getState())
                .district(item.getDistrict())
                .taluka(item.getTaluka())
                .village(item.getVillage())
                .gpsLatitude(item.getGpsLatitude())
                .gpsLongitude(item.getGpsLongitude())
                .gpsAccuracy(item.getGpsAccuracy())
                .startedAt(item.getStartedAtEpochMillis() != null
                        ? Instant.ofEpochMilli(item.getStartedAtEpochMillis())
                        : Instant.now())
                .build();
    }

    private void updateSurvey(Survey survey, BatchSyncItem item) {
        survey.setQuestionnaireId(item.getQuestionnaireId());
        survey.setLanguageUsed(item.getLanguageUsed());
        survey.setRespondentName(item.getRespondentName());
        survey.setRespondentAge(item.getRespondentAge());
        survey.setRespondentGender(item.getRespondentGender());
        survey.setState(item.getState());
        survey.setDistrict(item.getDistrict());
        survey.setTaluka(item.getTaluka());
        survey.setVillage(item.getVillage());
        survey.setGpsLatitude(item.getGpsLatitude());
        survey.setGpsLongitude(item.getGpsLongitude());
        survey.setGpsAccuracy(item.getGpsAccuracy());
        if (item.getStartedAtEpochMillis() != null) {
            survey.setStartedAt(Instant.ofEpochMilli(item.getStartedAtEpochMillis()));
        }
    }

    private Response buildResponse(UUID surveyId, ResponseRequest request) {
        JsonNode value = request.getResponseValue();
        if (value == null) {
            value = objectMapper.nullNode();
        }
        return Response.builder()
                .surveyId(surveyId)
                .questionId(request.getQuestionId())
                .responseType(request.getResponseType())
                .responseValue(value)
                .audioFileUrl(request.getAudioFileUrl())
                .rawTranscription(request.getRawTranscription())
                .cleanedTranscription(request.getCleanedTranscription())
                .wasEdited(request.isWasEdited())
                .answeredAt(request.getAnsweredAt())
                .build();
    }

    private void logSync(UUID surveyId, SyncStatus status, String errorMessage) {
        SyncLog log = SyncLog.builder()
                .surveyId(surveyId)
                .status(status)
                .errorMessage(errorMessage)
                .build();
        syncLogRepository.persist(log);
    }

    private SurveyDto toDto(Survey survey) {
        List<SurveyResponseDto> responses = responseRepository.findBySurvey(survey.getId()).stream()
                .map(r -> SurveyResponseDto.builder()
                        .id(r.getId())
                        .questionId(r.getQuestionId())
                        .responseType(r.getResponseType())
                        .responseValue(r.getResponseValue())
                        .audioFileUrl(r.getAudioFileUrl())
                        .wasEdited(r.isWasEdited())
                        .answeredAt(r.getAnsweredAt())
                        .build())
                .toList();

        return SurveyDto.builder()
                .id(survey.getId())
                .questionnaireId(survey.getQuestionnaireId())
                .surveyorId(survey.getSurveyorId())
                .clientSurveyId(survey.getClientSurveyId())
                .respondentName(survey.getRespondentName())
                .respondentAge(survey.getRespondentAge())
                .respondentGender(survey.getRespondentGender())
                .state(survey.getState())
                .district(survey.getDistrict())
                .taluka(survey.getTaluka())
                .village(survey.getVillage())
                .gpsLatitude(survey.getGpsLatitude())
                .gpsLongitude(survey.getGpsLongitude())
                .gpsAccuracy(survey.getGpsAccuracy())
                .languageUsed(survey.getLanguageUsed())
                .syncStatus(survey.getSyncStatus())
                .startedAt(survey.getStartedAt())
                .submittedAt(survey.getSubmittedAt())
                .createdAt(survey.getCreatedAt())
                .responses(responses)
                .build();
    }

    private String truncate(String message) {
        if (message == null) return null;
        return message.length() > 500 ? message.substring(0, 500) : message;
    }
}
