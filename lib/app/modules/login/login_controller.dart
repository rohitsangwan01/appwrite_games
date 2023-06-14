import 'package:appwrite_telegram/app/services/api_service.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  Future<String?> onLogin(LoginData loginData) async {
    try {
      String email = loginData.name;
      String password = loginData.password;
      await ApiService.to.login(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> onSignup(SignupData signUpData) async {
    try {
      String? email = signUpData.name;
      String? password = signUpData.password;
      String? userId = signUpData.additionalSignupData?["userId"];
      if (email == null || password == null || userId == null) {
        throw Exception("Invalid data");
      }
      await ApiService.to.signUp(userId, email, password);
      await ApiService.to.login(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void onLoginComplete() {
    Get.offAllNamed(Routes.HOME);
  }
}
