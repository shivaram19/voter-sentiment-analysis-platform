class QuestionModel {
  final String id;
  final String questionIdentifier;
  final Map<String, String> questionText;
  final String questionType;
  final List<String> options;
  final bool allowMultiple;
  final bool allowVoice;
  final bool isRequired;
  final bool captureGps;
  final Map<String, dynamic>? skipLogic;
  final int displayOrder;

  QuestionModel({
    required this.id,
    required this.questionIdentifier,
    required this.questionText,
    required this.questionType,
    required this.options,
    required this.allowMultiple,
    required this.allowVoice,
    required this.isRequired,
    required this.captureGps,
    this.skipLogic,
    required this.displayOrder,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      questionIdentifier: json['questionIdentifier'] ?? '',
      questionText: Map<String, String>.from(json['questionText'] ?? {}),
      questionType: json['questionType'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      allowMultiple: json['allowMultiple'] ?? false,
      allowVoice: json['allowVoice'] ?? false,
      isRequired: json['isRequired'] ?? true,
      captureGps: json['captureGps'] ?? false,
      skipLogic: json['skipLogic'],
      displayOrder: json['displayOrder'] ?? 0,
    );
  }
}
