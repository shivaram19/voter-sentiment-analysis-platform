package com.votersentiment.excel;

import com.votersentiment.excel.dto.ValidationResult;
import com.votersentiment.questionnaire.QuestionType;
import jakarta.enterprise.context.ApplicationScoped;
import org.apache.poi.ss.usermodel.*;

import java.util.*;

@ApplicationScoped
public class ExcelValidator {

    private static final int MAX_SHEETS = 10;
    private static final int MAX_ROWS = 500;
    private static final List<String> REQUIRED_COLUMNS = List.of(
            "question_id",
            "group_name",
            "question_text_en",
            "question_type",
            "options",
            "allow_multiple",
            "allow_voice",
            "required",
            "gps_capture",
            "display_order"
    );

    private static final List<String> LANGUAGE_COLUMNS = List.of(
            "question_text_hi",
            "question_text_ta"
    );

    public ValidationResult validate(Workbook workbook) {
        ValidationResult result = new ValidationResult();

        if (workbook.getNumberOfSheets() > MAX_SHEETS) {
            result.addError("Workbook has more than " + MAX_SHEETS + " sheets");
            return result;
        }

        if (workbook.getNumberOfSheets() == 0) {
            result.addError("Workbook has no sheets");
            return result;
        }

        DataFormatter formatter = new DataFormatter();

        for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
            Sheet sheet = workbook.getSheetAt(i);
            validateSheet(sheet, formatter, result);
        }

        return result;
    }

    private void validateSheet(Sheet sheet, DataFormatter formatter, ValidationResult result) {
        if (sheet.getPhysicalNumberOfRows() == 0) {
            result.addError("Sheet '" + sheet.getSheetName() + "' is empty");
            return;
        }

        if (sheet.getLastRowNum() > MAX_ROWS) {
            result.addError("Sheet '" + sheet.getSheetName() + "' has more than " + MAX_ROWS + " rows");
            return;
        }

        Row headerRow = sheet.getRow(0);
        if (headerRow == null) {
            result.addError("Sheet '" + sheet.getSheetName() + "' has no header row");
            return;
        }

        Map<String, Integer> headerIndex = new HashMap<>();
        for (Cell cell : headerRow) {
            String value = formatter.formatCellValue(cell).trim().toLowerCase();
            if (!value.isEmpty()) {
                headerIndex.put(value, cell.getColumnIndex());
            }
        }

        for (String required : REQUIRED_COLUMNS) {
            if (!headerIndex.containsKey(required)) {
                result.addError("Sheet '" + sheet.getSheetName() + "' is missing required column: " + required);
            }
        }

        for (String lang : LANGUAGE_COLUMNS) {
            if (!headerIndex.containsKey(lang)) {
                result.addWarning("Sheet '" + sheet.getSheetName() + "' is missing language column: " + lang);
            }
        }

        if (!result.isValid()) {
            return; // do not continue if structural errors exist
        }

        Set<String> identifiers = new HashSet<>();
        for (int r = 1; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) continue;

            String questionId = getCellValue(row, headerIndex.get("question_id"), formatter);
            if (questionId.isBlank()) {
                result.addError("Sheet '" + sheet.getSheetName() + "' row " + (r + 1) + ": question_id is required");
                continue;
            }
            if (!identifiers.add(questionId)) {
                result.addError("Sheet '" + sheet.getSheetName() + "' row " + (r + 1) + ": duplicate question_id '" + questionId + "'");
            }

            String typeValue = getCellValue(row, headerIndex.get("question_type"), formatter);
            QuestionType questionType;
            try {
                questionType = QuestionType.valueOf(typeValue.trim());
            } catch (IllegalArgumentException e) {
                result.addError("Sheet '" + sheet.getSheetName() + "' row " + (r + 1) + ": invalid question_type '" + typeValue + "'");
                continue;
            }

            if (questionType == QuestionType.single_choice || questionType == QuestionType.multi_select) {
                String options = getCellValue(row, headerIndex.get("options"), formatter);
                if (options == null || options.trim().isEmpty()) {
                    result.addError("Sheet '" + sheet.getSheetName() + "' row " + (r + 1) + ": options required for " + questionType);
                }
            }
        }
    }

    private String getCellValue(Row row, Integer col, DataFormatter formatter) {
        if (col == null || row == null) return "";
        Cell cell = row.getCell(col);
        if (cell == null) return "";
        return formatter.formatCellValue(cell).trim();
    }
}
