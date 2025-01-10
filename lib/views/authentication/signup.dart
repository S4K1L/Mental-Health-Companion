import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentalhealth/controller/signup_controller.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:mentalhealth/utils/constants/const.dart';
import 'package:mentalhealth/utils/widgets/password_text_field.dart';
import 'package:mentalhealth/utils/widgets/shared_functions.dart';
import 'package:mentalhealth/utils/widgets/text_text_field.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Size screenSize;
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              logo,
              height: 250,
            ),
            SizedBox(height: screenSize.height * 0.05),
            // Build welcome title
            const Text(
              "Create an Account",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Text(
              "Enter Your Details Here!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenSize.height * 0.025),
            // Build the body of the form
            Column(
              children: [
                // Build TextFields to get input of login credentials
                // Use the %30 of the screen size
                SizedBox(
                  height: screenSize.height * 0.4,
                  width: screenSize.width * 0.9,
                  child: Form(
                    key: signupController.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTextField(
                          controller: signupController.usernameController,
                          hintText: "Enter Your Username",
                          inputCheck: signupController.checkUserName,
                        ),
                        TextTextField(
                          controller: signupController.emailController,
                          hintText: "Enter Your Email",
                          inputCheck: checkEmail,
                          key: signupController.emailKey,
                        ),
                        PasswordTextField(
                          controller: signupController.passwordController,
                          hintText: "Enter Your password",
                        ),
                        buildSignUpButton(),
                      ],
                    ),
                  ),
                ),

                // Put some space so it'll look better
                SizedBox(height: screenSize.height * 0.02),

                buildOrWithSection(),

                SizedBox(height: screenSize.height * 0.025),

                // Build "Or With" section
                SizedBox(
                  height: screenSize.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Build SignUp text
                      buildLoginSection(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Build functions
  RichText buildLoginSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 18),
        children: [
          const TextSpan(
            text: "Have an account? ",
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: "Sign in",
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = openSignInPage,
          ),
        ],
      ),
    );
  }

  SizedBox buildSignUpButton() {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: 50,
      child: Obx(
            () => ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue[600]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () => signupController.signUp(
            signupController.emailController.text,
            signupController.passwordController.text,
          ),
          child: signupController.isLoading.value == false
              ? const Text(
            "Sign Up",
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

  void openSignInPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }
}