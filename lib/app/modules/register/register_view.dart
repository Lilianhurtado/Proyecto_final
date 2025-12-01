import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Chica indiscreta",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Crea tu cuenta para ver chismes",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),

                const SizedBox(height: 40),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => controller.name.value = value,
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => controller.email.value = value,
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: (value) => controller.password.value = value,
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Confirmar Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: (value) =>
                      controller.passwordConfirmation.value = value,
                ),

                const SizedBox(height: 30),

                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.onRegisterPressed,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Registrar"),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ya tienes cuenta?"),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.LOGIN),
                      child: const Text(
                        " Iniciar sesión",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
