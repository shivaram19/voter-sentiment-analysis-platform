package com.votersentiment.survey.dto;

import com.votersentiment.survey.SyncStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SurveyDto {

    private UUID id;
    private UUID questionnaireId;
    private UUID surveyorId;
    private UUID clientSurveyId;
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
    private String languageUsed;
    private SyncStatus syncStatus;
    private Instant startedAt;
    private Instant submittedAt;
    private Instant createdAt;
    private List<SurveyResponseDto> responses;
}
