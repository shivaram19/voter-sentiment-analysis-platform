class UserModel {
  final String id;
  final String username;
  final String name;
  final String role;
  final String? assignedRegion;

  const UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.role,
    this.assignedRegion,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return UserModel(
      id: data['id'] ?? '',
      username: data['username'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      assignedRegion: data['assignedRegion'],
    );
  }
}
