package com.votersentiment.excel;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.votersentiment.excel.dto.ParsedQuestionDto;
import com.votersentiment.excel.dto.ParsedSheetDto;
import com.votersentiment.excel.dto.UploadPreviewDto;
import com.votersentiment.excel.dto.ValidationResult;
import com.votersentiment.questionnaire.QuestionType;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.apache.poi.ss.usermodel.*;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ApplicationScoped
public class ExcelImportService {

    @Inject
    ExcelValidator validator;

    private final ObjectMapper objectMapper = new ObjectMapper();

    public UploadPreviewDto parseWorkbook(InputStream inputStream, String filename) throws IOException {
        try (Workbook workbook = WorkbookFactory.create(inputStream)) {
            ValidationResult validation = validator.validate(workbook);
            List<ParsedSheetDto> sheets = new ArrayList<>();

            if (validation.isValid()) {
                DataFormatter formatter = new DataFormatter();
                for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
                    Sheet sheet = workbook.getSheetAt(i);
                    ParsedSheetDto parsed = parseSheet(sheet, i, formatter);
                    if (!parsed.getQuestions().isEmpty()) {
                        sheets.add(parsed);
                    }
                }
            }

            return UploadPreviewDto.builder()
                    .validation(validation)
                    .sheets(sheets)
                    .build();
        }
    }

    private ParsedSheetDto parseSheet(Sheet sheet, int sheetIndex, DataFormatter formatter) {
        Row headerRow = sheet.getRow(0);
        Map<String, Integer> headerIndex = new HashMap<>();
        for (Cell cell : headerRow) {
            headerIndex.put(formatter.formatCellValue(cell).trim().toLowerCase(), cell.getColumnIndex());
        }

        String groupName = null;
        List<ParsedQuestionDto> questions = new ArrayList<>();

        for (int r = 1; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) continue;

            String qid = getCellValue(row, headerIndex.get("question_id"), formatter);
            if (qid.isBlank()) continue;

            if (groupName == null) {
                groupName = getCellValue(row, headerIndex.get("group_name"), formatter);
            }

            Map<String, String> questionText = new HashMap<>();
            addLanguageText(questionText, row, headerIndex, "question_text_en", "en", formatter);
            addLanguageText(questionText, row, headerIndex, "question_text_hi", "hi", formatter);
            addLanguageText(questionText, row, headerIndex, "question_text_ta", "ta", formatter);

            QuestionType type = QuestionType.valueOf(getCellValue(row, headerIndex.get("question_type"), formatter));

            List<String> options = null;
            if (type == QuestionType.single_choice || type == QuestionType.multi_select) {
                options = parseOptions(getCellValue(row, headerIndex.get("options"), formatter));
            }

            JsonNode skipLogic = null;
            String skipValue = headerIndex.containsKey("skip_logic")
                    ? getCellValue(row, headerIndex.get("skip_logic"), formatter)
                    : "";
            if (!skipValue.isBlank()) {
                try {
                    skipLogic = objectMapper.readTree(skipValue);
                } catch (Exception e) {
                    skipLogic = objectMapper.valueToTree(Map.of("raw", skipValue));
                }
            }

            ParsedQuestionDto question = ParsedQuestionDto.builder()
                    .questionIdentifier(qid)
                    .questionText(questionText)
                    .questionType(type)
                    .options(options)
                    .allowMultiple(parseBoolean(getCellValue(row, headerIndex.get("allow_multiple"), formatter)))
                    .allowVoice(parseBoolean(getCellValue(row, headerIndex.get("allow_voice"), formatter)))
                    .required(parseBoolean(getCellValue(row, headerIndex.get("required"), formatter)))
                    .gpsCapture(parseBoolean(getCellValue(row, headerIndex.get("gps_capture"), formatter)))
                    .skipLogic(skipLogic)
                    .displayOrder(parseInt(getCellValue(row, headerIndex.get("display_order"), formatter), r))
                    .build();
            questions.add(question);
        }

        if (groupName == null || groupName.isBlank()) {
            groupName = sheet.getSheetName();
        }

        return ParsedSheetDto.builder()
                .groupName(groupName)
                .sheetOrder(sheetIndex)
                .isOptional(false)
                .questions(questions)
                .build();
    }

    private void addLanguageText(Map<String, String> map, Row row, Map<String, Integer> headerIndex,
                                 String column, String lang, DataFormatter formatter) {
        Integer idx = headerIndex.get(column);
        if (idx != null) {
            String value = getCellValue(row, idx, formatter);
            if (!value.isBlank()) {
                map.put(lang, value);
            }
        }
    }

    private List<String> parseOptions(String raw) {
        if (raw == null || raw.isBlank()) return List.of();
        return List.of(raw.split("\\|"));
    }

    private boolean parseBoolean(String raw) {
        if (raw == null) return false;
        String value = raw.trim().toLowerCase();
        return value.equals("true") || value.equals("yes") || value.equals("1") || value.equals("y");
    }

    private int parseInt(String raw, int fallback) {
        try {
            return Integer.parseInt(raw.trim());
        } catch (Exception e) {
            return fallback;
        }
    }

    private String getCellValue(Row row, Integer col, DataFormatter formatter) {
        if (col == null || row == null) return "";
        Cell cell = row.getCell(col);
        if (cell == null) return "";
        return formatter.formatCellValue(cell).trim();
    }
}
