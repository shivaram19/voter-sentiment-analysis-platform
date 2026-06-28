package com.votersentiment.excel.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ParsedSheetDto {

    private String groupName;
    private int sheetOrder;
    private boolean isOptional;
    private List<ParsedQuestionDto> questions;
}
