package com.votersentiment.survey.dto;

import com.fasterxml.jackson.databind.JsonNode;
import com.votersentiment.survey.ResponseType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SurveyResponseDto {

    private UUID id;
    private UUID questionId;
    private ResponseType responseType;
    private JsonNode responseValue;
    private String audioFileUrl;
    private boolean wasEdited;
    private Instant answeredAt;
}
