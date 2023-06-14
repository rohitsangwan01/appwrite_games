import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:get/get.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
        pageColorLight: Colors.black,
        textFieldStyle: const TextStyle(color: Colors.white),
        inputTheme: const InputDecorationTheme(
          filled: true,
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
      logo: const AssetImage('assets/icon.png'),
      onLogin: controller.onLogin,
      onSignup: controller.onSignup,
      additionalSignupFields: const [
        UserFormField(keyName: 'userId', displayName: 'userId'),
      ],
      onSubmitAnimationCompleted: controller.onLoginComplete,
      loginAfterSignUp: true,
      hideForgotPasswordButton: true,
      onRecoverPassword: (_) => null,
    );
  }
}
