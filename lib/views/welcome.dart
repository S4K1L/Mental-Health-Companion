import 'package:flutter/material.dart';
import 'package:mentalhealth/utils/components/old_button.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:mentalhealth/views/authentication/login.dart';
import 'package:mentalhealth/views/authentication/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kBackGroundColor,
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Color(0xFFFAF3E0),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/welcome.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.5,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        "Chat Assistant \nfor Mental Health support",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily:
                          'Robot', // Default sans-serif font similar to the image
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black87, // Approximate text color
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "It's okay to ask for help. \nSeeking support is a sign of strength, not weakness.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.07),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            OldButton(title: "Register", onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },),
                            const SizedBox(width: 20),
                            OldButton(title: "Sign In", onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

