import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/login_response.dart';
import '../models/register_response.dart';

import '../../../utils/constants.dart';

class AuthProvider {
  //metodo login
  static Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return LoginResponse.fromJson(jsonData);
      } else {
        print("Error en Login: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception en Login: $e");
      return null;
    }
  }

  //metodo registro
  static Future<RegisterResponse?> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name, 
          "email": email,
          "password": password, 
          "password_confirmation": passwordConfirmation,
          }),
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return RegisterResponse.fromJson(jsonData);
      } else {
        print("Error en register: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception en Login: $e");
      return null;
    }
  }
}
