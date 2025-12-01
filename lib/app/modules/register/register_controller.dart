import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/providers/auth_provider.dart';

import '../../data/models/register_response.dart';
import '../../data/models/login_response.dart';

import '../../routes/app_routes.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  var name = "".obs;
  var email = "".obs;
  var password = "".obs;
  var passwordConfirmation = "".obs;

  Future<void> onRegisterPressed() async {
    if (name.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        passwordConfirmation.value.isEmpty) {
      print("Todos los campos son obligatorios");
      return;
    }

    if (password.value.isEmpty != passwordConfirmation.value.isEmpty) {
      print("Las contraseñas no coinciden");
      return;
    }

    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");

      final response = await AuthProvider.register(
        name: name.value,
        email: email.value,
        password: password.value,
        passwordConfirmation: passwordConfirmation.value,
      );

      if (response != null) {
        print("Usuario Registrado: ${response.name} (${response.email})");
        print("Mensaje: ${response.message}");

        final loginResponse = await AuthProvider.login(
          email.value,
          password.value,
        );

        if (loginResponse != null) {
          await prefs.setString("token", loginResponse.accessToken);

          print("Login Automatico tras registro");
          print("Token Guardado ${loginResponse.accessToken}");

          Get.offAllNamed(Routes.HOME);
        }else{
          print("No se pudo hacer login automatico tras el registro");
          Get.offAllNamed(Routes.LOGIN);
        }
      }else{
         print("Error en el registro, respuesta nula");
      }
    } catch (e) {
      print("Error en onRegisterPressed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
