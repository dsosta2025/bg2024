import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFeild extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Color? hintTextColor;
  final Color? fillColor;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffix;
  final Widget? prefix;
  final double? textFieldHeight;
  final FocusNode? focusNode;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextInputType? keyboardType; // New parameter
  final String? validator;
  final bool? typingEnabled;
  final String? heightFormat;

  const MyTextFeild(
      {super.key,
      this.controller,
      required this.hintText,
      this.onChange,
      this.textFieldHeight,
      this.suffix,
      this.fillColor,
      this.validator,
      this.focusNode,
      this.onSubmit,
      this.maxLines,
      this.maxLength,
      this.hintTextColor,
      this.keyboardType,
      this.typingEnabled,
      this.prefix,
      this.heightFormat});

  @override
  State<MyTextFeild> createState() => _MyTextFeildState();
}

class _MyTextFeildState extends State<MyTextFeild> {
  bool observeTextField = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    String inputText = widget.controller!.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          enabled: widget.typingEnabled ?? true,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          onChanged: widget.onChange,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: widget.controller,
          cursorColor: AppColors.orange2,
          maxLines: widget.maxLines ?? 1,

          obscureText: widget.validator == 'Password' ? observeTextField : false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: height*0.022,horizontal: width*0.035),
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
          ),


          validator: (value) {
            if (widget.validator == "Password") {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }

              // Password validation: At least 6 characters
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            }
            // else if (widget.validator == "Height") {
            //   print('Height validation');
            //   print(widget.controller?.text);
            //   print(widget.heightFormat);
            //   print(value);
            //
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter the Value';
            //   }
            //
            //   // Regular expression to match numbers with up to 2 decimal places
            //   final RegExp decimalRegExp = RegExp(r'^\d+(\.\d{1,2})?$');
            //
            //   if (!decimalRegExp.hasMatch(value)) {
            //     return 'Please enter a valid height with up to 2 decimal places';
            //   }
            //   if (widget.heightFormat == 'cm') {
            //     if (double.parse(value) < 60 || double.parse(value) > 304) {
            //       return 'Height must be between 60 and 304 cm';
            //     }
            //   } else if (widget.heightFormat == 'Feet') {
            //     if (double.parse(value) < 2 || double.parse(value) > 10) {
            //       return 'Height must be between 2 and 10 Feet';
            //     }
            //   }
            //
            //   return null;
            // }
            else if (widget.validator == "Email") {
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegExp.hasMatch(value!)) {
                return 'Please enter a valid email address';
              }
            } else if (widget.validator == "Phone") {
              // Phone number validation: 10 digits
              final phoneRegExp = RegExp(r'^\d{10}$');
              if (!phoneRegExp.hasMatch(value!)) {
                return 'Please enter a valid phone number';
              }
            } else if (widget.validator == "Name") {
              // Updated regex to allow letters, numbers, underscores, and spaces
              // final usernameRegExp = RegExp(r'^[a-zA-Z0-9_ ]+$');
              print(widget.validator);
              // final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
              // final usernameRegExp = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$');
              final usernameRegExp = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$');

              // final usernameRegExp = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$');

              // print("(((((((+++++++++++++++++)))))))");
              // print(inputText.isEmpty);
              // if (inputText.trim().isEmpty) {
              //   return 'Name cannot be empty';
              // }
              // print(widget.controller!.text.isEmpty);
              // print(value);
              if (!usernameRegExp.hasMatch(value!) ||
                  inputText.trim().isEmpty) {
                return 'Only letters and a single space between words are allowed';
              }
              return null;
            }
            else if (widget.validator == "optional") {
              // Phone number validation: 10 digits
              return null;
            }
            else if (value == null || value.isEmpty) {
              // _debouncer.run(() {
              //
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Center(
              //         child: MyTextLato(
              //           text: "Please enter the Value In Each Field",
              //           fontSize: width * 0.035,
              //         )),
              //   ));
              // });
              return 'Please enter the Value';
            }

            // else if (inputText.trim().isEmpty) {
            //   return 'Filed Cannot be empty or only contain spaces ';
            // }
          },
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onSubmit,
        ),
      ],
    );
  }
}
// decoration: InputDecoration(
//   suffixIcon: widget.validator == 'Password'
//       ? IconButton(
//           onPressed: () {
//             setState(() {
//               observeTextField = !observeTextField;
//             });
//           },
//           icon: Icon(
//             observeTextField
//                 ? Icons.remove_red_eye_outlined
//                 : Icons.remove_red_eye,
//             color: AppColors.orange2,
//             size: width * 0.06,
//           ),
//         )
//       : widget.suffix ?? const SizedBox(),
//   floatingLabelBehavior: FloatingLabelBehavior.never,
//   hintText: widget.hintText,
//   hintStyle: GoogleFonts.manrope(
//     color: AppColor.primaryColor1,
//     fontSize: width * 0.03,
//     fontWeight: FontWeight.w700,
//   ),
//   contentPadding: EdgeInsets.only(top: 0, left: width * 0.035),
//   hoverColor: AppColor.primaryColor1,
//   border: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.primaryColor1,
//       width: 1.4,
//     ),
//   ),
//   disabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.primaryColor1,
//       width: 1.4,
//     ),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.primaryColor1,
//       width: 1.4,
//     ),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.primaryColor1,
//       width: 1.4,
//     ),
//   ),
//   errorBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: Colors.red,
//       width: 1.4,
//     ),
//   ),
//   fillColor: widget.fillColor ?? Colors.transparent,
//   filled: true,
//   focusColor: Colors.black,
// ),