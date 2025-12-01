import 'package:get/get.dart';

import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';

import '../modules/register/register_binding.dart';
import '../modules/register/register_view.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';

import '../modules/post_detail/post_detail_binding.dart';
import '../modules/post_detail/post_detail_view.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.POST_DETAIL,
      page: () {
        final slug = Get.arguments as String;
        return PostDetailView(slug : slug);
      },
      binding: PostDetailBinding(),
    ),
  ];
}
