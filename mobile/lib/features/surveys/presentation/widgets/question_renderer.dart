import 'package:flutter/material.dart';

import '../../../questionnaires/domain/question_model.dart';
import 'long_text_widget.dart';
import 'multi_select_widget.dart';
import 'single_choice_widget.dart';

class QuestionRenderer extends StatelessWidget {
  final QuestionModel question;
  final dynamic response;
  final void Function(dynamic) onChanged;

  const QuestionRenderer({
    super.key,
    required this.question,
    required this.response,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final text = question.questionText['en'] ?? question.questionText.values.firstOrNull ?? 'Question';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: Theme.of(context).textTheme.titleMedium),
        if (question.captureGps)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('GPS will be captured', style: Theme.of(context).textTheme.bodySmall),
          ),
        const SizedBox(height: 16),
        _buildInput(),
      ],
    );
  }

  Widget _buildInput() {
    switch (question.questionType) {
      case 'single_choice':
        return SingleChoiceWidget(
          options: question.options,
          selected: response as String?,
          onChanged: onChanged,
        );
      case 'multi_select':
        return MultiSelectWidget(
          options: question.options,
          selected: (response as List<dynamic>?)?.cast<String>() ?? [],
          onChanged: onChanged,
        );
      case 'long_text':
      case 'long_text_voice':
      default:
        return LongTextWidget(
          value: response as String?,
          onChanged: onChanged,
        );
    }
  }
}
