import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/questionnaire_model.dart';

class QuestionnaireCard extends StatelessWidget {
  final QuestionnaireModel questionnaire;

  const QuestionnaireCard({super.key, required this.questionnaire});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(questionnaire.title),
        subtitle: Text(questionnaire.description ?? 'No description'),
        trailing: Chip(
          label: Text(questionnaire.isActive ? 'Active' : 'Inactive'),
          backgroundColor: questionnaire.isActive ? Colors.green.shade100 : Colors.grey.shade300,
        ),
        onTap: () => context.push('/survey/${questionnaire.id}'),
      ),
    );
  }
}
