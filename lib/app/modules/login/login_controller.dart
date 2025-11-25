import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/providers/auth_provider.dart';
import '../../data/models/login_response.dart';

import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var email = "".obs;
  var password = "".obs;

  Future<void> onLoginPressed() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      print("Email o password vacios");
      return;
    }

    try {
      isLoading.value = true;
      final response = await AuthProvider.login(email.value, password.value);

      if (response != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.accessToken);

        print("Login Exitoso.Token:: ${response.accessToken}");
        print("Usuario: ${response.user.name} (${response.user.email})");

        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      print("Error en onLoginPressed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
