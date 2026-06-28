package com.votersentiment.questionnaire.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuestionGroupDto {

    private UUID id;
    private String groupName;
    private int sheetOrder;
    private boolean isOptional;
    private List<QuestionDto> questions;
}
