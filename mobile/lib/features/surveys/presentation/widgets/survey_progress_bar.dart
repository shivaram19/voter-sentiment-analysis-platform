import 'package:flutter/material.dart';

class SurveyProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const SurveyProgressBar({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : current / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 4),
        Text('Question $current of $total', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
