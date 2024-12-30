import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'profileSection/controller/profileController.dart';



class EditProfile extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();

  EditProfile({super.key}) {
    // Initialize controllers with current user data
    final currentUser = userController.currentUser.value!;
    fullNameController.text = currentUser.fullName;
    emailController.text = currentUser.email;
    phoneController.text = currentUser.phone;
    designationController.text = currentUser.designation;
    organizationController.text = currentUser.organization;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0.05.h,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.blueGradient,
              ),
            ),
          ),
          Positioned(
            top: 25.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 36.w),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100.h,
            left: 0,
            right: 0,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 1,
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 247, 247),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              width: 393.w,
              height: 761.h,
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await userController.pickImage();
                      },
                      child: Obx(
                        () => userController.selectedImage.value != null
                            ? CircleAvatar(
                          backgroundColor: Colors.white,
                                radius: 60.r,
                                backgroundImage: FileImage(
                                  userController.selectedImage.value!,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    userController.currentUser.value!.imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                      backgroundColor: Colors.white,

                                      radius: 60.r,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) => SizedBox(
                                  width: 60.r,
                                  height: 60.r,
                                  child: const CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                      backgroundColor: Colors.white,

                                      radius: 60.r,
                                  backgroundImage:
                                      const AssetImage('lib/assets/user.png'),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildEditableField(
                        Icons.person, "Full Name", fullNameController),
                    _buildEditableField(Icons.email, "Email", emailController),
                    _buildEditableField(Icons.phone, "Phone", phoneController),
                    _buildEditableField(
                        Icons.work, "Designation", designationController),
                    _buildEditableField(
                        Icons.business, "Organization", organizationController),
                    SizedBox(height: 30.h),
                    Obx(
                      () => CustomeButton(
                        text: userController.isEditing.value
                            ? "Saving..."
                            : "Save Changes",
                        onPressed: userController.isEditing.value
                            ? () {}
                            : () async {
                                await userController.editProfile(
                                  fullName: fullNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  designation: designationController.text,
                                  organization: organizationController.text,
                                );
                                if (userController.editErrorMessage.isEmpty) {
                                  Get.back();
                                }
                              },
                        horizontalPadding: width * 0.15,
                        verticalPadding: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(
      IconData icon, String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
      child: MyTextFeild(
        hintText: hint,
        controller: controller,
      ),
    );
  }
}

// class EditProfile extends StatelessWidget {
//   final UserController userController = Get.find<UserController>();
//
//   EditProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//
//     // TextEditingControllers for each field
//     final fullNameController = TextEditingController();
//     final emailController = TextEditingController();
//     final phoneController = TextEditingController();
//     final designationController = TextEditingController();
//     final organizationController = TextEditingController();
//     final imageUrlController = TextEditingController();
//
//     // Initialize controllers with current user data
//     final currentUser = userController.currentUser.value;
//     if (currentUser != null) {
//       fullNameController.text = currentUser.fullName;
//       emailController.text = currentUser.email;
//       phoneController.text = currentUser.phone;
//       designationController.text = currentUser.designation;
//       organizationController.text = currentUser.organization;
//       imageUrlController.text = currentUser.imageUrl;
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 0.05.h,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.white,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: AppColors.blueGradient,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 25.h,
//             left: 20.w,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.arrow_back,
//                     size: 24,
//                     color: AppColors.white,
//                   ),
//                   SizedBox(width: 36.w),
//                   Text(
//                     'Edit Profile',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 100.h,
//             left: 0,
//             right: 0,
//             child: Container(
//               constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 1),
//               decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 249, 247, 247),
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30),
//                       topLeft: Radius.circular(30))),
//               width: 393.w,
//               height: 761.h,
//               child: Padding(
//                 padding: EdgeInsets.all(20.r),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CircleAvatar(
//                       radius: 60.r,
//                       backgroundImage: imageUrlController.text.isNotEmpty
//                           ? NetworkImage(imageUrlController.text)
//                           : const AssetImage('lib/assets/Profile image.png')
//                               as ImageProvider,
//                     ),
//                     SizedBox(height: 20.h),
//
//                     // Editable Fields
//                     _buildEditableField(
//                         Icons.person, "Full Name", fullNameController),
//                     _buildEditableField(
//                         Icons.business, "Designation", designationController),
//                     _buildEditableField(
//                         Icons.business, "Organization", organizationController),
//                     _buildEditableField(Icons.email, "Email", emailController),
//                     _buildEditableField(
//                         Icons.phone, "Phone Number", phoneController),
//                     _buildEditableField(
//                         Icons.image, "Image URL", imageUrlController),
//
//                     SizedBox(height: 30.h),
//
//                     // Save Changes Button
//                     CustomeButton(
//                       text: "Save changes",
//                       onPressed: () async {
//                         await userController.editProfile(
//                           fullName: fullNameController.text,
//                           email: emailController.text,
//                           phone: phoneController.text,
//                           designation: designationController.text,
//                           organization: organizationController.text,
//                           imageUrl: imageUrlController.text,
//                         );
//
//                         Navigator.pop(context);
//                       },
//                       horizontalPadding: width * 0.15,
//                       verticalPadding: 12,
//                     ),
//                     SizedBox(height: 30.h),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget for editable fields
//   Widget _buildEditableField(
//       IconData icon, String hintText, TextEditingController controller) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
//       child: Row(
//         children: [
//           Icon(icon, size: 24, color: Colors.black54),
//           SizedBox(width: 10.w),
//           Expanded(
//             child: MyTextFeild(
//               hintText: hintText,
//               controller: controller,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EditProfile extends StatelessWidget {
//   const EditProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 0.05.h,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.white,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: AppColors.blueGradient,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 25.h,
//             left: 20.w,
//             child: GestureDetector(
//               onTap: () {
//                Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.arrow_back,
//                     size: 24,
//                     color: AppColors.white,
//                   ),
//                   SizedBox(width: 36.w),
//                   Text(
//                     ' Edit Profile',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 100.h,
//             left: 0,
//             right: 0,
//             child: Container(
//               constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 1),
//               decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 249, 247, 247),
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30),
//                       topLeft: Radius.circular(30))),
//               width: 393.w,
//               height: 761.h,
//               child: Padding(
//                 padding: EdgeInsets.all(20.r),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CircleAvatar(
//                       radius: 60.r,
//                       backgroundImage:
//                           const AssetImage('lib/assets/Profile image.png'),
//                     ),
//                     SizedBox(height: 20.h),
//
//                     // User Name
//                     Text(
//                       'Ralph Edwards',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.dark,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//
//                     // Role (Insurer)
//                     _buildProfileDetail(Icons.person, 'insurer'),
//
//                     _buildProfileDetail(Icons.business, 'Xsentinal'),
//
//                     // Email
//                     _buildProfileDetail(Icons.email, 'email@domain.com'),
//
//                     // Phone Number
//                     _buildProfileDetail(Icons.phone, '+91 888 888 9595'),
//
//                     SizedBox(height: 30.h),
//
//                     //const Spacer(),
//                     // Buttons: Logout and Delete Account
//                     CustomeButton(
//                       text: "Save changes",
//                       onPressed: () {},
//                       horizontalPadding: width * 0.15,
//                       verticalPadding: 12,
//                     ),
//                     SizedBox(height: 30.h),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Widget for profile details
// Widget _buildProfileDetail(IconData icon, String text) {
//   TextEditingController controller = TextEditingController();
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
//     child: MyTextFeild(
//       hintText: text,
//       controller: controller,
//     )
//   );
// }
