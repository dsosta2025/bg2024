import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final VoidCallback? onPressed; // Add onPressed parameter to handle tap action

  const CreateAccountButton(
      {super.key, this.onPressed}); // Accept the onPressed callback

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Call the onPressed callback when tapped
      child: Container(
        width: 275, // Set width
        height: 52, // Set height
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
        child: const Center(
          child: Text(
            'Create an Account',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16, // Font size
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
