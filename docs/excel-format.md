# Excel Format

Each sheet represents one question group. The sheet name itself is not authoritative; the `group_name` column is.

## Required columns

| Column | Description |
|--------|-------------|
| `question_id` | Unique within sheet |
| `group_name` | Name of the question group |
| `question_text_en` | English question text |
| `question_text_hi` | Hindi question text |
| `question_text_ta` | Tamil question text |
| `question_type` | `single_choice`, `multi_select`, `long_text`, `long_text_voice` |
| `options` | Pipe-separated options for choice questions |
| `allow_multiple` | `true`/`false` |
| `allow_voice` | `true`/`false` |
| `required` | `true`/`false` |
| `gps_capture` | `true`/`false` |
| `skip_logic` | Optional JSON string |
| `display_order` | Integer order |

## Validation rules

- Max 10 sheets per workbook.
- Required columns must be present.
- `question_id` must be unique within a sheet.
- `question_type` must be a valid enum value.
- Choice questions must have non-empty `options`.
- Missing non-English language columns produce a warning, not an error.
