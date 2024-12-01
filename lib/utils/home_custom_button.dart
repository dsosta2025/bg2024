import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const HomeCustomButton({
    super.key,
    required this.text,
    required this.onPressed, // Remove required since it is optional now
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ??
          () {}, // Provide a default empty callback if onPressed is null
      child: Container(
        width: 108,
        height: 33,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.orangeGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 9.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                  fontFamily: 'Poppins', // Use the Poppins font
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 7),
              child: Icon(
                Icons.arrow_forward,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
