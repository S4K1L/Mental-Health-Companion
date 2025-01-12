import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mentalhealth/controller/profile_controller.dart';
import 'package:mentalhealth/models/user_model.dart';
import 'package:mentalhealth/utils/components/bottom_bar.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:mentalhealth/utils/constants/const.dart';
import 'package:mentalhealth/utils/widgets/text_text_field.dart';
import 'package:mentalhealth/views/authentication/login.dart';

import 'login_controller.dart';

class SignupController extends GetxController {
  // Controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<TextTextFieldState>();

  // Firestore and FirebaseAuth instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Reactive Variables
  var userModel = UserModel().obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;

  GlobalKey<FormState> get formKey => _formKey;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Validate form and show snackbar
  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      _showSnackbar(
        title: 'Invalid Input',
        message: 'Please check your all data',
      );
      return false;
    }
    return true;
  }

  // Handle Firestore user creation
  Future<void> _saveUserToFirestore(User user) async {
    userModel.value = UserModel(
      name: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    await _firestore.collection('users').doc(user.uid).set({
      'name': userModel.value.name,
      'email': userModel.value.email,
      'password': userModel.value.password,
      'role': 'user',
      'uid': user.uid,
    });
  }

  // Display snackbars for success or errors
  void _showSnackbar({
    required String title,
    required String message,
    Color color = kPrimaryColor,
    Color textColor = kWhiteColor,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: textColor,
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
    );
  }

  // Signup logic
  Future<void> signUp(String email, String password) async {
    isLoading.value = true;

    try {
      // Validate form
      if (!_validateForm()) {
        isLoading.value = false;
        return;
      }

      // Firebase Authentication
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user == null) {
        throw Exception('User creation failed: No user object returned.');
      }

      // Save user to Firestore
      await _saveUserToFirestore(user);

      // Success feedback
      _showSnackbar(
        title: 'Registration Successful',
        message: 'Welcome to Mental Health Support',
      );

      // Clear form data (example assuming a controller or variable holds email and password)
      emailController.clear();
      passwordController.clear();

      // Navigate to login page
      logout();
    } catch (e) {
      if (kDebugMode) {
        print("Error in registering: $e");
      }

      // Error feedback
      _showSnackbar(
        title: 'Error',
        message: 'Registration failed: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();

        // Reset all models to their initial empty state
        userModel.value = UserModel();
        // Clear cache and delete UserController (if needed)
        await Get.delete<ProfileController>();
        await Get.delete<LoginController>();
        await Get.delete<SignupController>();
        // Navigate to login page
        Get.offAll(() => const LoginPage(), transition: Transition.leftToRight);
      } else {
        if (kDebugMode) {
          print("No user is currently signed in");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error logging out: $e");
      }
      Get.snackbar('Error', 'An error occurred. Please try again.');
      rethrow;
    }
  }

  // Username validation
  String checkUserName(String updatedText) {
    if (updatedText.length < 2) {
      return "Username must contain more than 2 characters!";
    }
    return "";
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
