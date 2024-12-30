import 'package:bima_gyaan/pages/home_pages/buy_sponsor_section/controller/buy_sponser_controller.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistorFormToBuySponsor extends StatelessWidget {
  final String sponserType;
  final String eventId;
  final BuySponsorController controller = Get.put(BuySponsorController());

  RegistorFormToBuySponsor({
    super.key,
    required this.sponserType,
    required this.eventId,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    var spacer = SizedBox(
      height: height * 0.03,
    );

    return ReusableBackGroundScreen(
      appBarTitle: 'Buy Sponsorship',
      isBookSlot: true,
      singleView: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.03,
            horizontal: width * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                spacer,
                MyTextFeild(
                  hintText: 'Name',
                  controller: nameController,
                  validator: 'Name', // Validator logic added
                ),
                spacer,
                MyTextFeild(
                  hintText: 'Email',
                  controller: emailController,
                  validator: 'Email', // Validator logic added
                ),
                spacer,
                MyTextFeild(
                  hintText: 'Company Name',
                  controller: companyNameController,
                  validator: '', // Validator logic added
                ),
                spacer,
                MyTextFeild(
                  hintText: 'Company GST no.',
                  controller: gstNumberController,
                  validator: '', // Validator logic added
                ),
                spacer,
                buildDataContainer(width, height),
                spacer,
                CustomButton(
                  text: 'Submit',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await controller.submitSponsorData(
                        sponsorType: sponserType,
                        eventId: eventId,
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        companyName: companyNameController.text.trim(),
                        gstNumber: gstNumberController.text.trim(),
                      );
                      Get.back();
                      clearForm();
                    } else {
                      CustomSnackbarr.show(
                        Get.context!,
                        "Error",
                        "Please fill all fields correctly.",
                        isError: true,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDataContainer(double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.009, horizontal: width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              controller.selectedDate.value,
              style: TextStyle(
                color: Colors.grey,
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                controller.selectedDate.value =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
              }
            },
            icon: Icon(
              Icons.calendar_month,
              size: width * 0.05,
            ),
          ),
        ],
      ),
    );
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    companyNameController.clear();
    gstNumberController.clear();
    controller.selectedDate.value = "Date";
  }
}

// class RegistorFormToBuySponsor extends StatelessWidget {
//   String sponserType;
//   String eventId;
//
//   RegistorFormToBuySponsor(
//       {super.key, required this.sponserType, required this.eventId});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//
//     TextEditingController textEditingController = TextEditingController();
//
//     var spacer = SizedBox(
//       height: height * 0.03,
//     );
//
//     return ReusableBackGroundScreen(
//       appBarTitle: 'Buy sponsorship',
//       isBookSlot: true,
//       singleView: Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: height * 0.03, horizontal: width * 0.05),
//         child: Column(
//           children: [
//             spacer,
//             MyTextFeild(
//               hintText: 'Name',
//               controller: textEditingController,
//             ),
//             spacer,
//             MyTextFeild(
//               hintText: 'Email',
//               controller: textEditingController,
//             ),
//             spacer,
//             MyTextFeild(
//               hintText: 'company Name',
//               controller: textEditingController,
//             ),
//             spacer,
//             MyTextFeild(
//               hintText: 'Company GST no.',
//               controller: textEditingController,
//             ),
//             spacer,
//             buildDataContainer(width, height),
//             spacer,
//             CustomButton(text: 'Submit', onPressed: () {})
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildDataContainer(double width, double height) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           vertical: height * 0.009, horizontal: width * 0.035),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Date",
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: width * 0.035,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.calendar_month,
//                 size: width * 0.05,
//               ))
//         ],
//       ),
//     );
//   }
// }
