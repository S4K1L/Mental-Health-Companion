import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalhealth/utils/components/admin_bottom_bar.dart';
import 'package:mentalhealth/utils/components/bottom_bar.dart';
import 'package:mentalhealth/views/welcome.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _route();
            return const SizedBox.shrink();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
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

}