class RegisterResponse {
  final String message;
  final int id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;

  RegisterResponse({
    required this.message,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final user = json["user"];
    return RegisterResponse(
      message: json["message"],
      id: user["id"],
      name: user["name"],
      email: user["email"],
      role: user["role"],
      createdAt: user["created_at"],
      updatedAt: user["updated_at"],
    );
  }
}
