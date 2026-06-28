package com.votersentiment.survey.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BatchSyncResultItem {

    private UUID clientSurveyId;
    private UUID serverSurveyId;
    private String status;
    private String errorMessage;
}
