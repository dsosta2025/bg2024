import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed, // Remove required since it is optional now
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onPressed, // Provide a default empty callback if onPressed is null
      child: Container(
        width: width * 0.67,
        height: height * 0.06,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.orangeGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppColors.white,
                fontSize: width * 0.04,
                fontFamily: 'Poppins', // Use the Poppins font
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05),
              child: Icon(
                Icons.arrow_forward,
                size: width * 0.05,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
