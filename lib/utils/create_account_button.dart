import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final VoidCallback? onPressed; // Callback for tap action

  const CreateAccountButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width; // Screen width
    final height = size.height; // Screen height

    return GestureDetector(
      onTap: onPressed, // Call the onPressed callback when tapped
      child: Container(
        width: width*0.67,
        height: height*0.06,
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(12), // Slightly curved edges
          border: Border.all(
            color: const Color(0xFFF05D31), // First border color
            width: 2.0, // Border width
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Offset for the shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Create an Account',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: width * 0.04, // Font size relative to screen width
              fontWeight: FontWeight.w600, // Font weight
              color: Colors.black, // Text color
            ),
            textAlign: TextAlign.center, // Center text alignment
          ),
        ),
      ),
    );
  }
}
