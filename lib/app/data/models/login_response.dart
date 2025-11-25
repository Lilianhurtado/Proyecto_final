import 'user_model.dart';


class LoginResponse {
  final String accessToken;
  final String tokenType;
  final User user;
 

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["accessToken"],
      tokenType: json["tokenType"],
      user: User.fromJson(json["user"]),
    );
  }
}
