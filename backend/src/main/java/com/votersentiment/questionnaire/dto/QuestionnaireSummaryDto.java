package com.votersentiment.questionnaire.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.Map;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuestionnaireSummaryDto {

    private UUID id;
    private String title;
    private String description;
    private UUID createdById;
    private boolean isActive;
    private Map<String, String> languageSupport;
    private Instant createdAt;
    private Instant updatedAt;
}
