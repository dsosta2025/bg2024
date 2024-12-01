import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double horizontalPadding;
   final double verticalPadding;
  final Color? textColour;
  final bool transparent;
  final double? borderRadius;
  final double? borderWidth;
  final Icon? icon; // Optional icon parameter
  final double? textSize; // Optional text size parameter
  final Gradient? gradient; // New gradient parameter

  const CustomeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.horizontalPadding = 70.0,
    this.verticalPadding = 9.0,
    this.textColour,
    this.transparent = false,
    this.borderRadius, // Optional user-defined border radius
    this.borderWidth, // Optional user-defined border width
    this.icon, // Optional icon
    this.textSize, // Optional text size
    this.gradient, // Gradient for button background
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final defaultBorderRadius = size.width * 0.027;
    final defaultTextSize = size.width * 0.035; // Default text size
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;


    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? defaultBorderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),


        decoration: BoxDecoration(
          gradient:transparent?null: gradient ??
            AppColors.getOrangeGradient(),
          borderRadius: BorderRadius.circular(borderRadius ?? defaultBorderRadius),
          border: Border.all(
            color: transparent ? AppColors.orange2:Colors.transparent,
            width: borderWidth ?? 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: textSize ?? defaultTextSize,
                fontWeight: FontWeight.w600,
                color: transparent?Colors.black: Colors.white,
              ),

            ),
            if (icon != null) ...[
              SizedBox(width: 8.0), // Spacing between text and icon
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
