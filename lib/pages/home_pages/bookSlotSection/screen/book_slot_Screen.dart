import 'package:bima_gyaan/pages/home_pages/bookSlotSection/controller/book_slot_controller.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookSlotScreen extends StatefulWidget {
  final String eventId;

  BookSlotScreen({super.key, required this.eventId});

  @override
  State<BookSlotScreen> createState() => _BookSlotScreenState();
}

class _BookSlotScreenState extends State<BookSlotScreen> {
  final BookSlotController bookSlotController = Get.put(BookSlotController());

  // Controllers for individual form fields
  final TextEditingController individualNameController =
      TextEditingController();
  final TextEditingController individualEmailController =
      TextEditingController();
  final TextEditingController individualDateController =
      TextEditingController();
  final TextEditingController individualUploadIdController =
      TextEditingController();

  // Controllers for organization form fields
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController organizationEmailController =
      TextEditingController();
  final TextEditingController organizationDateController =
      TextEditingController();
  final TextEditingController organizationCompanyNameController =
      TextEditingController();
  final TextEditingController organizationPaxController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var spacer = SizedBox(height: height * 0.03);

    final individual = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Column(
        children: [
          MyTextFeild(
            hintText: 'Name',
            controller: individualNameController,
          ),
          spacer,
          MyTextFeild(
            hintText: 'Email',
            controller: individualEmailController,
          ),
          spacer,
          buildDatePicker(
            context: context,
            controller: individualDateController,
          ),
          spacer,
          MyTextFeild(
            hintText: 'Upload ID',
            controller: individualUploadIdController,
          ),
          spacer,
          CustomButton(
            text: 'Book Slot',
            onPressed: () {
              bookSlotController.addIndividualSlot(
                eventId: widget.eventId,
                name: individualNameController.text.trim(),
                email: individualEmailController.text.trim(),
                date: individualDateController.text.trim(),
                uploadId: individualUploadIdController.text.trim(),
              );
            },
          )
        ],
      ),
    );

    final organization = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Column(
        children: [
          MyTextFeild(
            hintText: 'Name',
            controller: organizationNameController,
          ),
          spacer,
          MyTextFeild(
            hintText: 'Email',
            controller: organizationEmailController,
          ),
          spacer,
          buildDatePicker(
            context: context,
            controller: organizationDateController,
          ),
          spacer,
          MyTextFeild(
            hintText: 'Company Name',
            controller: organizationCompanyNameController,
          ),
          spacer,
          MyTextFeild(
            hintText: 'No. of Pax',
            controller: organizationPaxController,
          ),
          spacer,
          CustomButton(
            text: 'Book Slot',
            onPressed: () {
              bookSlotController.addOrganizationSlot(
                eventId: widget.eventId,
                name: organizationNameController.text.trim(),
                email: organizationEmailController.text.trim(),
                date: organizationDateController.text.trim(),
                companyName: organizationCompanyNameController.text.trim(),
                pax: organizationPaxController.text.trim(),
              );
            },
          )
        ],
      ),
    );

    return ReusableBackGroundScreen(
      tabTitles: ["Individual", "Organization"],
      tabViews: [individual, organization],
      isBookSlot: true,
      appBarTitle: 'Book Slot',
    );
  }

  Widget buildDatePicker({
    required BuildContext context,
    required TextEditingController controller,
  }) {
    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) {
          controller.text = selectedDate.toLocal().toString().split(' ')[0];
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.text.isEmpty ? "Select Date" : controller.text,
              style: TextStyle(color: Colors.grey),
            ),
            Icon(Icons.calendar_today, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers to prevent memory leaks
    individualNameController.dispose();
    individualEmailController.dispose();
    individualDateController.dispose();
    individualUploadIdController.dispose();
    organizationNameController.dispose();
    organizationEmailController.dispose();
    organizationDateController.dispose();
    organizationCompanyNameController.dispose();
    organizationPaxController.dispose();
    super.dispose();
  }
}
//
// class BookSlotScreen extends StatefulWidget {
//    BookSlotScreen({super.key, required this.eventId});
//   String eventId;
//   @override
//   State<BookSlotScreen> createState() => _BookSlotScreenState();
// }
// class _BookSlotScreenState extends State<BookSlotScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//     TextEditingController textEditingController = TextEditingController();
//     var spacer = SizedBox(
//       height: height * 0.03,
//     );
//     final individual = Padding(
//       padding: EdgeInsets.symmetric(
//           vertical: height * 0.02, horizontal: width * 0.05),
//       child: Column(
//         children: [
//           MyTextFeild(
//             hintText: 'Name',
//             controller: textEditingController,
//           ),
//           spacer,
//           MyTextFeild(
//             hintText: 'Email',
//             controller: textEditingController,
//           ),
//           spacer,
//           buildDataContainer(width, height),
//           spacer,
//           MyTextFeild(
//             hintText: 'Uplode Id',
//             controller: textEditingController,
//           ),
//           spacer,
//           CustomButton(text: 'Book Slot', onPressed: () {})
//         ],
//       ),
//     );
//
//     final organization = Padding(
//       padding: EdgeInsets.symmetric(
//           vertical: height * 0.02, horizontal: width * 0.05),
//       child: Column(
//         children: [
//           MyTextFeild(
//             hintText: 'Name',
//             controller: textEditingController,
//           ),
//           spacer,
//           MyTextFeild(
//             hintText: 'Email',
//             controller: textEditingController,
//           ),
//
//           spacer,
//           buildDataContainer(width, height),
//           spacer,
//           MyTextFeild(
//             hintText: 'company Name',
//             controller: textEditingController,
//           ),
//           spacer,
//           MyTextFeild(
//             hintText: 'no. of pax',
//             controller: textEditingController,
//           ),
//           spacer,
//           CustomButton(text: 'Book Slot', onPressed: () {})
//         ],
//       ),
//     );
//
//
//
//     return ReusableBackGroundScreen(
//       tabTitles: [
//         "Individual",
//         "Organization",
//       ],
//       tabViews: [
//         individual,
//         organization,
//       ],
//       isBookSlot: true,
//       appBarTitle: 'Book Slot',
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
