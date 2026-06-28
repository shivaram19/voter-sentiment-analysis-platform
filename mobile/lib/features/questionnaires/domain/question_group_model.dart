import 'question_model.dart';

class QuestionGroupModel {
  final String id;
  final String groupName;
  final int sheetOrder;
  final bool isOptional;
  final List<QuestionModel> questions;

  QuestionGroupModel({
    required this.id,
    required this.groupName,
    required this.sheetOrder,
    required this.isOptional,
    required this.questions,
  });

  factory QuestionGroupModel.fromJson(Map<String, dynamic> json) {
    return QuestionGroupModel(
      id: json['id'] ?? '',
      groupName: json['groupName'] ?? '',
      sheetOrder: json['sheetOrder'] ?? 0,
      isOptional: json['isOptional'] ?? false,
      questions: (json['questions'] as List? ?? [])
          .map((q) => QuestionModel.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }
}
