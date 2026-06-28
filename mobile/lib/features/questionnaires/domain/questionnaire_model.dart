import 'question_group_model.dart';

class QuestionnaireModel {
  final String id;
  final String title;
  final String? description;
  final bool isActive;
  final Map<String, String> languageSupport;
  final List<QuestionGroupModel> groups;

  QuestionnaireModel({
    required this.id,
    required this.title,
    this.description,
    required this.isActive,
    required this.languageSupport,
    required this.groups,
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      isActive: json['isActive'] ?? false,
      languageSupport: Map<String, String>.from(json['languageSupport'] ?? {}),
      groups: (json['groups'] as List? ?? [])
          .map((g) => QuestionGroupModel.fromJson(g as Map<String, dynamic>))
          .toList(),
    );
  }
}
