package com.votersentiment.questionnaire.dto;

import com.fasterxml.jackson.databind.JsonNode;
import com.votersentiment.questionnaire.QuestionType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuestionDto {

    private UUID id;
    private String questionIdentifier;
    private Map<String, String> questionText;
    private QuestionType questionType;
    private List<String> options;
    private boolean allowMultiple;
    private boolean allowVoice;
    private boolean isRequired;
    private boolean captureGps;
    private JsonNode skipLogic;
    private int displayOrder;
}
