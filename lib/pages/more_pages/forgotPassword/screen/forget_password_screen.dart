import 'package:bima_gyaan/pages/login_screen/screen/login_screen.dart';
import 'package:bima_gyaan/pages/more_pages/forgotPassword/controller/forgotPasswordController.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/common_button_forgot.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  // Initialize the controller
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: _buildConfirmationDialogContent(),
        );
      },
    );
  }

  Widget _buildConfirmationDialogContent() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'lib/assets/Tick.gif',
            height: 100.h,
          ),
          SizedBox(height: 10.h),
          const Text(
            'Forgot Password',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Password reset instructions will be sent via email.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: AppColors.dark.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          CustomButtonForgot(
            text: 'Back to login',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Start the password reset process
      controller.sendPasswordResetEmail(emailController.text).then((value) {
        _showConfirmationDialog();
      }).catchError((e) {
        // Handle failure
        CustomSnackbarr.show(Get.context!, 'Error', e.toString(),
            isError: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 15.h,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.blueGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
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
      constraints: BoxConstraints(
        maxHeight: 0.8.sh,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 249, 247, 247),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBackButton(),
            SizedBox(height: 20.h),
            _buildEmailPrompt(),
            SizedBox(height: 30.h),
            _buildEmailTextField(),
            SizedBox(height: 25.h),
            Obx(() {
              // Check if loading state is true and show loading indicator
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }

              return CustomButtonForgot(
                text: 'Submit',
                onPressed: _handleSubmit,
              );
            }),
            const Spacer(),
            _buildSponsorInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back,
            size: 24,
          ),
          SizedBox(width: 50.w),
          Text(
            'Forgot password',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailPrompt() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Enter your registered email',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: emailController,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        filled: true,
        hintText: 'Enter your email',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.r),
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

  Widget _buildSponsorInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 18.h),
      child: Row(
        children: [
          Column(
            children: [
              const Text(
                'Sponsored by',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
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
          const Spacer(),
          const Text(
            'Powered by',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 10.w),
          Image.asset(
            'lib/assets/logo_bigGyan.png',
            width: 46.w,
            height: 48.h,
          ),
        ],
      ),
    );
  }
}

// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({super.key});
//
//   @override
//   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
// }
//
// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//
//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: _buildConfirmationDialogContent(),
//         );
//       },
//     );
//   }
//
//   Widget _buildConfirmationDialogContent() {
//     return Container(
//       padding: EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             'lib/assets/Tick.gif',
//             height: 100.h,
//           ),
//           SizedBox(height: 10.h),
//           const Text(
//             'Forgot Password',
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Password reset instructions will be sent via email.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.normal,
//               fontSize: 14,
//               color: AppColors.dark.withOpacity(0.7),
//             ),
//           ),
//           const SizedBox(height: 16),
//           CustomButtonForgot(
//             text: 'Back to login',
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _handleSubmit(ForgotPasswordController controller) {
//     if (_formKey.currentState!.validate()) {
//
//       controller.sendPasswordResetEmail(emailController.text).then((value) {
//         _showConfirmationDialog();
//
//       },);
//     }
//   }
// ForgotPasswordController controller  = Get.put(ForgotPasswordController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 15.h,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: AppColors.blueGradient,
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: AppColors.blueGradient,
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   SizedBox(height: 50.h),
//                   _buildLogo(),
//                   SizedBox(height: 30.h),
//                   _buildFormContainer(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLogo() {
//     return Image.asset(
//       'lib/assets/BG LOGO2.png',
//       height: 59.h,
//       width: 137.w,
//     );
//   }
//
//   Widget _buildFormContainer() {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: 0.8.sh,
//       ),
//       decoration: const BoxDecoration(
//         color: Color.fromARGB(255, 249, 247, 247),
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//       ),
//       width: double.infinity,
//       child: Padding(
//         padding: EdgeInsets.all(20.r),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildBackButton(),
//             SizedBox(height: 20.h),
//             _buildEmailPrompt(),
//             SizedBox(height: 30.h),
//             _buildEmailTextField(),
//             SizedBox(height: 25.h),
//             CustomButtonForgot(
//               text: 'Submit',
//               onPressed:(){
//                 _handleSubmit(controller);
//               },
//             ),
//             const Spacer(),
//             _buildSponsorInfo(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBackButton() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//         );
//       },
//       child: Row(
//         children: [
//           const Icon(
//             Icons.arrow_back,
//             size: 24,
//           ),
//           SizedBox(width: 50.w),
//           Text(
//             'Forgot password',
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 22.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmailPrompt() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         'Enter your registered email',
//         style: TextStyle(
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w500,
//           fontSize: 16.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmailTextField() {
//     return TextFormField(
//       controller: emailController,
//       style: TextStyle(
//         fontFamily: 'Poppins',
//         fontSize: 14.sp,
//       ),
//       decoration: InputDecoration(
//         fillColor: const Color.fromARGB(255, 255, 255, 255),
//         filled: true,
//         hintText: 'Enter your email',
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Email is required';
//         } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//           return 'Enter a valid email';
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildSponsorInfo() {
//     return Padding(
//       padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 18.h),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               const Text(
//                 'Sponsored by',
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Image.asset(
//                 'lib/assets/Plus Logo.png',
//                 width: 69.82.w,
//                 height: 16.h,
//               ),
//             ],
//           ),
//           const Spacer(),
//           const Text(
//             'Powered by',
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Image.asset(
//             'lib/assets/logo_bigGyan.png',
//             width: 46.w,
//             height: 48.h,
//           ),
//         ],
//       ),
//     );
//   }
// }
