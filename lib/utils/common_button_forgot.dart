import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonForgot extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButtonForgot({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        width: 275,
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.orangeGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
