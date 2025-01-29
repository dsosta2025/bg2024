import 'dart:ffi';

import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controller/createAccoutController.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

SignUpController controller = Get.put(SignUpController());
class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  bool _obscurePassword = true;
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          _buildBody(),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.03, horizontal: width * 0.03),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: width * 0.065,
                    )),
              )),
          Obx(() => signUpController.isLoading.value
              ? Container(
                  width: width,
                  height: height,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.orange2,
                      strokeWidth: width * 0.0025,
                    ),
                  ),
                )
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.blueGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50.h),
              _buildLogo(),
              SizedBox(height: 30.h),
              _buildFormContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'lib/assets/BG LOGO2.png',
      height: 59.h,
      width: 137.w,
    );
  }

  Widget _buildFormContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 249, 247, 247),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      width: 393.w,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            _buildTitle(),
            SizedBox(height: 30.h),
            _buildTextField(fullNameController, 'Enter your full name',
                'Full name is required'),
            SizedBox(height: 20.h),
            _buildEmailField(),
            SizedBox(height: 20.h),
            _buildPhoneField(),
            SizedBox(height: 20.h),
            _buildPasswordField(),
            SizedBox(height: 20.h),
            _buildTextField(organizationController, 'Organisation',
                'Organisation is required'),
            SizedBox(height: 20.h),
            _buildTextField(designationController, 'Designation',
                'Designation is required'),
            SizedBox(height: 20.h),
            _buildCreateAccountButton(),
            SizedBox(height: 20.h),
            _buildAlternativeOptions(),
            // SizedBox(height: 20.h),
            // _buildSocialMediaLogos(),
            SizedBox(height: 20.h),
            _buildSponsoredBySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Create Account',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
      ),
      decoration: _inputDecoration('Enter your email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }


  Widget _buildPhoneField() {
    return IntlPhoneField(
      controller: phoneController,
      decoration: _inputDecoration('Enter phone number'),
      initialCountryCode: 'IN',
      onChanged: (phone) {


        print(phoneController.text);
        print(phone.completeNumber);

        controller.completeNumber.value = phone.completeNumber;
        print(controller.completeNumber);

      },
      onCountryChanged: (value) {
        // controller.selectedCountryCode.value = value.fullCountryCode;

        // Recompute the complete phone number
        String currentNumber = phoneController.text; // Get the current phone number
        String updatedCompleteNumber = '+${value.fullCountryCode}$currentNumber';
        print("Updated Complete Number: $updatedCompleteNumber");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        controller.completeNumber.value = updatedCompleteNumber;
        print(controller.completeNumber.value);
      },
      validator: (value) {
        if (value == null || value.completeNumber.isEmpty) {
          return 'Phone number is required';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: _obscurePassword,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        filled: true,
        hintText: 'Create Password',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.r),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }

        final passwordRegex = RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,}$');
        if (!passwordRegex.hasMatch(value)) {
          return 'Password must be at least 10 characters, include uppercase, lowercase, number, and special character';
        }
        return null;
      },
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, String errorMessage) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
      ),
      decoration: _inputDecoration(hintText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      filled: true,
      hintText: hintText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return CustomButton(
      text: 'Create Account',
      onPressed: () {
        print(controller.completeNumber.value);
        if (_formKey.currentState!.validate()) {
          signUpController.signUp(
              fullName: fullNameController.text.trim(),
              email: emailController.text.trim(),
              phone: controller.completeNumber.value.trim(),
              password: passwordController.text.trim(),
              organization: organizationController.text.trim(),
              designation: designationController.text.trim(),
              context: context);
        }
      },
    );
  }

  // Widget _buildCreateAccountButton() {
  //   return CustomButton(
  //     text: 'Create Account',
  //     onPressed: () {
  //       if (_formKey.currentState!.validate()) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const LoginScreen()),
  //         );
  //       }
  //     },
  //   );
  // }

  Widget _buildAlternativeOptions() {
    return const Text(
      'Or create account with',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  Widget _buildSocialMediaLogos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialMediaLogo('lib/assets/Facebook.png'),
        SizedBox(width: 10.w),
        _buildSocialMediaLogo('lib/assets/Google.png'),
        SizedBox(width: 10.w),
        _buildSocialMediaLogo('lib/assets/Instagram.png'),
        SizedBox(width: 10.w),
        _buildSocialMediaLogo('lib/assets/LinkedIn.png'),
      ],
    );
  }

  Widget _buildSocialMediaLogo(String assetPath) {
    return Image.asset(
      assetPath,
      width: 48.w,
      height: 48.h,
    );
  }

  Widget _buildSponsoredBySection() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSponsoredBy(),
          _buildPoweredBy(),
        ],
      ),
    );
  }

  Widget _buildSponsoredBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sponsored by',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Image.asset(
          'lib/assets/Plus Logo.png',
          width: 69.82.w,
          height: 16.h,
        ),
      ],
    );
  }

  Widget _buildPoweredBy() {
    return Row(
      children: [
        const Text(
          'Powered by',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 5.w),
        Image.asset(
          'lib/assets/logo_bigGyan.png',
          width: 66.w,
          height: 23.h,
        ),
      ],
    );
  }
}
