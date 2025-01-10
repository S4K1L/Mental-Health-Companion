import 'package:flutter/material.dart';

import '../constants/colors.dart';

class OldButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const OldButton({
    super.key, required this.title, required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
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
        child: Text(title,style: const TextStyle(color: kBlackColor),),
      ),
    );
  }
}