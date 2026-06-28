package com.votersentiment.survey.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;
import java.util.UUID;

@Data
public class BatchSyncItem {

    @NotNull(message = "clientSurveyId is required")
    private UUID clientSurveyId;

    @NotNull(message = "questionnaireId is required")
    private UUID questionnaireId;

    private String languageUsed;
    private String respondentName;
    private Integer respondentAge;
    private String respondentGender;
    private String state;
    private String district;
    private String taluka;
    private String village;
    private Double gpsLatitude;
    private Double gpsLongitude;
    private Double gpsAccuracy;
    private Long startedAtEpochMillis;
    private Long submittedAtEpochMillis;

    @Valid
    private List<ResponseRequest> responses;
}
