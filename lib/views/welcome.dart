import 'package:flutter/material.dart';
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
          color: const Color(0xFFFAF3E0),
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
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  WidgetStateProperty.all<Color>(
                                      Colors.white),
                                  padding: WidgetStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  textStyle:
                                  WidgetStateProperty.all<TextStyle>(
                                    const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                child: const Text("Register"),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  WidgetStateProperty.all<Color>(
                                      Colors.white70.withOpacity(0.9)),
                                  padding: WidgetStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  textStyle:
                                  WidgetStateProperty.all<TextStyle>(
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black45.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                child: const Text("Sign In"),
                              ),
                            ),
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