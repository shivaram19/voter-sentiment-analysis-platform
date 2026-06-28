package com.votersentiment.survey.dto;

import com.fasterxml.jackson.databind.JsonNode;
import com.votersentiment.survey.ResponseType;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.Instant;
import java.util.UUID;

@Data
public class ResponseRequest {

    @NotNull(message = "questionId is required")
    private UUID questionId;

    @NotNull(message = "responseType is required")
    private ResponseType responseType;

    @NotNull(message = "responseValue is required")
    private JsonNode responseValue;

    private String audioFileUrl;
    private String rawTranscription;
    private String cleanedTranscription;
    private boolean wasEdited;
    private Instant answeredAt;
}
