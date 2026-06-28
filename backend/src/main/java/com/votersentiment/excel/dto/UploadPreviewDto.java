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
public class UploadPreviewDto {

    private ValidationResult validation;
    private List<ParsedSheetDto> sheets;
}
