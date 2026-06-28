package com.votersentiment.admin.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DashboardStatsDto {

    private long totalQuestionnaires;
    private long activeQuestionnaires;
    private long totalSurveyors;
    private long totalSurveys;
    private long pendingSurveys;
    private long syncedSurveys;
    private long failedSurveys;
}
