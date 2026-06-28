package com.votersentiment.excel.dto;

import com.fasterxml.jackson.databind.JsonNode;
import com.votersentiment.questionnaire.QuestionType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ParsedQuestionDto {

    private String questionIdentifier;
    private Map<String, String> questionText;
    private QuestionType questionType;
    private List<String> options;
    private boolean allowMultiple;
    private boolean allowVoice;
    private boolean required;
    private boolean gpsCapture;
    private JsonNode skipLogic;
    private int displayOrder;
}
