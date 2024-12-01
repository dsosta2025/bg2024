import 'package:flutter/material.dart';

class socialMediaButton extends StatelessWidget {
  const socialMediaButton({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle social media button press
      },
      child: Image.asset(
        imagePath,
        width: 48,
        height: 48,
      ),
    );
  }
}
