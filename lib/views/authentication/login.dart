// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentalhealth/controller/login_controller.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:mentalhealth/utils/constants/const.dart';
import 'package:mentalhealth/utils/widgets/password_text_field.dart';
import 'package:mentalhealth/utils/widgets/shared_functions.dart';
import 'package:mentalhealth/utils/widgets/text_text_field.dart';
import 'package:mentalhealth/views/chatbot.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  late Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Image.asset(
                        logo,
                        height: 250,
                      ),
                      buildWelcomeTitle(),
                      SizedBox(height: screenSize.height * 0.025),
                      Expanded(
                        child: Form(
                          key: loginController.formKey,
                          child: Column(
                            children: [
                              buildEmailField(),
                              SizedBox(height: screenSize.height * 0.035),
                              buildPasswordField(),
                              SizedBox(height: screenSize.height * 0.015),
                              Row(
                                children: [
                                  Spacer(),
                                  buildForgotPassword(),
                                ],
                              ),
                              SizedBox(height: screenSize.height * 0.015),
                              buildLoginButton(context),
                              SizedBox(height: screenSize.height * 0.035),
                              buildOrWithSection(),
                              SizedBox(height: screenSize.height * 0.015),
                              buildSingUpSection(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Build functions
  Row buildWelcomeTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Hello, There! 🤖",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: 50,
      child: Obx(
        () => FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blue[600],
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () => loginController.loginUser(),
          child: loginController.waitingFirebaseResponse.value == false
              ? Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )
              : LoadingAnimationWidget.inkDrop(color: Colors.white, size: 30),
        ),
      ),
    );
  }

  TextButton buildForgotPassword() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Forgot your password?",
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue,
        ),
      ),
    );
  }

  SizedBox buildEmailField() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: TextStyle(fontSize: 16),
          ),
          TextTextField(
            key: loginController.emailKey,
            controller: loginController.emailController,
            hintText: "Enter email",
            inputCheck: checkEmail,
          ),
        ],
      ),
    );
  }

  SizedBox buildPasswordField() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password",
            style: TextStyle(fontSize: 16),
          ),
          PasswordTextField(
            key: loginController.passwordKey,
            controller: loginController.passwordController,
            hintText: "Enter password",
          ),
        ],
      ),
    );
  }

  RichText buildSingUpSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 18),
        children: [
          TextSpan(
            text: "Don't  have an account? ",
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: "Sign up",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = loginController.openSignUpPage,
          ),
        ],
      ),
    );
  }

  void openMainPage() {
    Get.to(() => ChattingScreen());
  }
}
