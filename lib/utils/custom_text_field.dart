import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
        borderRadius:
            BorderRadius.circular(60), // Curved edges (adjust as needed)
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true, // Ensures the background color is applied
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60), // Matching curved edges
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60),
            borderSide: const BorderSide(
                color: Colors.blue, width: 2), // Focused state border
          ),
        ),
      ),
    );
  }
}
