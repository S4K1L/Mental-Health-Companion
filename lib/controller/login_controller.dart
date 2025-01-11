import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalhealth/utils/components/admin_bottom_bar.dart';
import 'package:mentalhealth/utils/components/bottom_bar.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:mentalhealth/utils/widgets/password_text_field.dart';
import 'package:mentalhealth/utils/widgets/text_text_field.dart';
import 'package:mentalhealth/views/authentication/signup.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers for input fields
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<TextTextFieldState>();
  final passwordKey = GlobalKey<PasswordTextFieldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Password visibility toggle
  RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Function to log in user
  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    isLoading(true);

    if (email.isEmpty || password.isEmpty) {
      isLoading(false);
      Get.snackbar("Error", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        'Success',
        'Logged in successfully!',
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );
      // Navigate to the home page or desired page
      _route();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void _route() async {
    User? user = FirebaseAuth.instance.currentUser;
    var documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    if (documentSnapshot.exists) {
      String userType = documentSnapshot.get('role');
      if (userType == "user") {
        Get.offAll(()=> const BottomBar());
      }
      else if (userType == "admin") {
        Get.offAll(()=> const AdminBottomBar());
      }
      else {
        print('user data not found');
      }
    }
    else {
      print('user data not found');
    }
  }


  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Check your mail",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kBackGroundColor,
          colorText: Colors.white);
    } catch (error) {
      if (kDebugMode) {
        print('Error resetting password: $error');
      }
      rethrow;
    }
  }

  void openSignUpPage() {
    Get.to(()=> const RegisterPage());
  }
}