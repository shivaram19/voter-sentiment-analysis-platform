package com.votersentiment.survey.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.UUID;

@Data
public class StartSurveyRequest {

    @NotNull(message = "questionnaireId is required")
    private UUID questionnaireId;

    @NotNull(message = "clientSurveyId is required")
    private UUID clientSurveyId;

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
}
