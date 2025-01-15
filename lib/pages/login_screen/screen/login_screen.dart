import 'package:bima_gyaan/pages/createAccount/screens/create_account.dart';
import 'package:bima_gyaan/pages/more_pages/forgotPassword/screen/forget_password_screen.dart';
import 'package:bima_gyaan/pages/login_screen/controller/loginController.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/create_account_button.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
LoginController controller = Get.put(LoginController());
class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                    _buildLoginForm(),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => controller.isLoading.value
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

  Widget _buildLogo() {
    return Image.asset(
      'lib/assets/BG LOGO2.png',
      height: 59.h,
      width: 137.w,
    );
  }

  Widget _buildLoginForm() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 249, 247, 247),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildLoginTitle(),
          SizedBox(height: 30.h),
          _buildEmailField(),
          SizedBox(height: 20.h),
          _buildPasswordField(),
          SizedBox(height: 20.h),
          _buildForgotPasswordLink(),
          SizedBox(height: 20.h),
          _buildLoginButton(),
          SizedBox(height: 20.h),
          _buildCreateAccountButton(),
          SizedBox(height: 20.h),
          // _buildSocialLoginOptions(),
          SizedBox(height: 20.h),
          _buildSponsorInfo(),
        ],
      ),
    );
  }
  Widget _buildLoginTitle() {
    return Text(
      'Login',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Enter your email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
      ),
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

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
      ),
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Enter password',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ForgetPasswordScreen(),
          ),
        ),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      text: 'Login',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          controller.login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        }
      },
    );
  }

  // Widget _buildLoginButton() {
  //   return CustomButton(
  //     text: 'Login',
  //     onPressed: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const HomeScreen(),
  //         ),
  //       );
  //       // if (_formKey.currentState!.validate()) {
  //       //
  //       // }
  //     },
  //   );
  // }

  Widget _buildCreateAccountButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CreateAccountButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAccountScreen(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginOptions() {
    return Column(
      children: [
        Text(
          'Or login with',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  controller.signInWithGoogle();
                },
                child: _buildSocialIcon('lib/assets/Google.png')),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Image.asset(
        assetPath,
        width: 48.w,
        height: 48.h,
      ),
    );
  }

  Widget _buildSponsorInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Sponsored by',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.h),
              Image.asset(
                'lib/assets/Plus Logo.png',
                width: 69.82.w,
                height: 16.h,
              ),
            ],
          ),
          SizedBox(width: 50.w),
          Text(
            'Powered by',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 10.w),
          Image.asset(
            'lib/assets/Xsentinel.png',
            width: 46.w,
            height: 48.h,
          ),
        ],
      ),
    );
  }
}
