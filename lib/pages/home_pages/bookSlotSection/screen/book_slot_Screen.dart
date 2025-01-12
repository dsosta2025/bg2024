import 'package:bima_gyaan/pages/home_pages/bookSlotSection/controller/book_slot_controller.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeSncakBar.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
  final TextEditingController individualUploadIdController =
      TextEditingController();

  // Controllers for organization form fields
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController organizationEmailController =
      TextEditingController();
  final TextEditingController organizationCompanyNameController =
      TextEditingController();
  final TextEditingController organizationPaxController =
      TextEditingController();

  // Form keys for validation
  final _individualFormKey = GlobalKey<FormState>();
  final _organizationFormKey = GlobalKey<FormState>();

  Razorpay razorpay = Razorpay();
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Log the success
    print("Payment Success: ${response.paymentId}");
    print("Order ID: ${response.orderId}");
    print("Signature: ${response.signature}");

    try {
      if (bookSlotController.isOrganization.value) {
        // Organization booking logic
        await bookSlotController.addOrganizationSlot(
          eventId: widget.eventId,
          name: organizationNameController.text.trim(),
          email: organizationEmailController.text.trim(),
          companyName: organizationCompanyNameController.text.trim(),
          pax: organizationPaxController.text.trim(),
        );

        // Clear organization fields
        organizationNameController.clear();
        organizationEmailController.clear();
        organizationCompanyNameController.clear();
        organizationPaxController.clear();
      } else {
        // Individual booking logic
        await bookSlotController.addIndividualSlot(
          eventId: widget.eventId,
          name: individualNameController.text.trim(),
          email: individualEmailController.text.trim(),
          uploadId: individualUploadIdController.text.trim(),
        );

        // Clear individual fields
        individualNameController.clear();
        individualEmailController.clear();
        individualUploadIdController.clear();
      }

      // Notify user of success
      CustomSnackbarr.show(
        context,
        "Success",
        "Payment successful and slot booked.",
        isError: false,
      );
    } catch (e) {
      // Handle slot booking error
      CustomSnackbarr.show(
        context,
        "Error",
        "Payment was successful, but slot booking failed: $e",
        isError: true,
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Log the failure
    print("Payment Failure: ${response.code}");
    print("Message: ${response.message}");

    // Notify user of failure
    CustomSnackbarr.show(
      context,
      "Payment Error",
      "Payment failed. Please try again.",
      isError: true,
    );
  }

  //
  // void _handlePaymentSuccess(PaymentSuccessResponse response) async{
  //   // Do something when payment succeeds
  //
  //   print("Successsssssssssssssssssssssssssssssssssss");
  //
  //   await bookSlotController.addIndividualSlot(
  //     eventId: widget.eventId,
  //     name: individualNameController.text.trim(),
  //     email: individualEmailController.text.trim(),
  //     uploadId: individualUploadIdController.text.trim(),
  //   );
  //
  //   // Clear the fields after booking
  //   individualNameController.clear();
  //   individualEmailController.clear();
  //   individualUploadIdController.clear();
  //   // // Pop the screen after successful booking
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  // }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var spacer = SizedBox(height: height * 0.03);


    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    final individual = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Form(
        key: _individualFormKey,
        child: Column(
          children: [
            MyTextFeild(
              hintText: 'Name',
              controller: individualNameController,
              validator: 'Name',
            ),
            spacer,
            MyTextFeild(
              hintText: 'Email',
              controller: individualEmailController,
              validator: 'Email',
            ),
            spacer,
            buildDataContainer(width, height, context, bookSlotController),
            spacer,
            MyTextFeild(
              hintText: 'Upload ID',
              controller: individualUploadIdController,
              validator: 'optional',
            ),
            spacer,
            CustomButton(
              text: 'Submit',
              onPressed: () async {
                if (_individualFormKey.currentState?.validate() ?? false) {
                  // Calculate total amount with GST
                  double baseAmount = 8000;
                  double gst = baseAmount * 0.18;
                  double totalAmount = baseAmount + gst;
                  bookSlotController.isOrganization.value = false; // Individual booking

                  var options = {
                    'key': 'rzp_test_g8KgIfsUPcMvUS',
                    'amount': (totalAmount * 100).toInt(), // Convert to paise
                    'name': individualNameController.text.trim(),
                    'description': 'Individual Payment',
                    'prefill': {
                      'contact': individualUploadIdController.text.trim(),
                      'email': individualEmailController.text.trim(),
                    },
                  };
                  razorpay.open(options);
                } else {
                  CustomSnackbarr.show(
                    context,
                    "Error",
                    "Please fill all required fields correctly",
                    isError: true,
                  );
                }
              },
            ),

            // CustomButton(
            //   text: 'Submit',
            //   onPressed: () async {
            //     if (_individualFormKey.currentState?.validate() ?? false) {
            //
            //
            //       var options = {
            //         'key': 'rzp_test_g8KgIfsUPcMvUS',
            //         'amount': 8000,
            //         'name': individualNameController.text.trim(),
            //         'description': 'Indivusual ',
            //         'prefill': {
            //           'contact': individualUploadIdController.text.trim(),
            //           'email': individualEmailController.text.trim()
            //         }
            //       };
            //       razorpay.open(options);
            //
            //       // Navigator.of(context).pop();
            //     } else {
            //       CustomSnackbarr.show(
            //         context,
            //         "Error",
            //         "Please fill all required fields correctly",
            //         isError: true,
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );

    final organization = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Form(
        key: _organizationFormKey,
        child: Column(
          children: [
            MyTextFeild(
              hintText: 'Name',
              controller: organizationNameController,
              validator: 'Name',
            ),
            spacer,
            MyTextFeild(
              hintText: 'Email',
              controller: organizationEmailController,
              validator: 'Email',
            ),
            spacer,
            buildDataContainer(width, height, context, bookSlotController),
            spacer,
            MyTextFeild(
              hintText: 'Company Name',
              controller: organizationCompanyNameController,
              validator: '',
            ),
            spacer,
            MyTextFeild(
              hintText: 'No. of Pax',
              controller: organizationPaxController,
              validator: '',
            ),
            spacer,

            CustomButton(
              text: 'Submit',
              onPressed: () async {
                if (_organizationFormKey.currentState?.validate() ?? false) {
                  int pax = int.tryParse(organizationPaxController.text.trim()) ?? 0;

                  // Validate pax
                  if (pax <= 0 || pax > 25) {
                    CustomSnackbarr.show(
                      context,
                      "Error",
                      "Number of people (pax) must be between 1 and 25.",
                      isError: true,
                    );
                    return;
                  }
                  bookSlotController.isOrganization.value = true; // Individual booking


                  // Calculate total amount with GST for pax
                  double baseAmount = 8000;
                  double gst = baseAmount * 0.18;
                  double totalAmount = (baseAmount + gst) * pax;

                  var options = {
                    'key': 'rzp_test_g8KgIfsUPcMvUS',
                    'amount': (totalAmount * 100).toInt(), // Convert to paise
                    'name': organizationNameController.text.trim(),
                    'description': 'Organization Payment for $pax people',
                    'prefill': {
                      'contact': organizationEmailController.text.trim(),
                      'email': organizationEmailController.text.trim(),
                    },
                  };
                  razorpay.open(options);
                } else {
                  CustomSnackbarr.show(
                    context,
                    "Error",
                    "Please fill all required fields correctly",
                    isError: true,
                  );
                }
              },
            ),

            // CustomButton(
            //   text: 'Book Slot',
            //   onPressed: () async {
            //     if (_organizationFormKey.currentState?.validate() ?? false) {
            //       await bookSlotController.addOrganizationSlot(
            //         eventId: widget.eventId,
            //         name: organizationNameController.text.trim(),
            //         email: organizationEmailController.text.trim(),
            //         companyName: organizationCompanyNameController.text.trim(),
            //         pax: organizationPaxController.text.trim(),
            //       );
            //
            //       // Clear the fields after booking
            //       organizationNameController.clear();
            //       organizationEmailController.clear();
            //       organizationCompanyNameController.clear();
            //       organizationPaxController.clear();
            //       // Pop the screen after successful booking
            //       Navigator.of(context).pop();
            //     } else {
            //       CustomSnackbarr.show(
            //         context,
            //         "Error",
            //         "Please fill all required fields correctly",
            //         isError: true,
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );

    return ReusableBackGroundScreen(
      tabTitles: ["Individual", "Organization"],
      tabViews: [
        SingleChildScrollView(child: individual),
        SingleChildScrollView(child: organization)
      ],
      isBookSlot: true,
      appBarTitle: 'Book Slot',
    );
  }

  Widget buildDataContainer(double width, double height, BuildContext context,
      BookSlotController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.0065, horizontal: width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              controller.selectedDate.value,
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
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
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers to prevent memory leaks
    individualNameController.dispose();
    individualEmailController.dispose();
    individualUploadIdController.dispose();
    organizationNameController.dispose();
    organizationEmailController.dispose();
    organizationCompanyNameController.dispose();
    organizationPaxController.dispose();
    super.dispose();
  }
}

// class BookSlotScreen extends StatefulWidget {
//   final String eventId;
//
//   BookSlotScreen({super.key, required this.eventId});
//
//   @override
//   State<BookSlotScreen> createState() => _BookSlotScreenState();
// }
//
// class _BookSlotScreenState extends State<BookSlotScreen> {
//   final BookSlotController bookSlotController = Get.put(BookSlotController());
//
//   // Controllers for individual form fields
//   final TextEditingController individualNameController =
//       TextEditingController();
//   final TextEditingController individualEmailController =
//       TextEditingController();
//   final TextEditingController individualDateController =
//       TextEditingController();
//   final TextEditingController individualUploadIdController =
//       TextEditingController();
//
//   // Controllers for organization form fields
//   final TextEditingController organizationNameController =
//       TextEditingController();
//   final TextEditingController organizationEmailController =
//       TextEditingController();
//
//   // final TextEditingController organizationDateController =
//   //     TextEditingController();
//   final TextEditingController organizationCompanyNameController =
//       TextEditingController();
//   final TextEditingController organizationPaxController =
//       TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     var spacer = SizedBox(height: height * 0.03);
//
//     final individual = Padding(
//       padding: EdgeInsets.symmetric(
//           vertical: height * 0.02, horizontal: width * 0.05),
//       child: Column(
//         children: [
//           MyTextFeild(
//             hintText: 'Name',
//             controller: individualNameController,
//             validator: '',
//           ),
//           spacer,
//           MyTextFeild(
//             hintText: 'Email',
//             controller: individualEmailController,
//             validator: '',
//           ),
//           spacer,
//           buildDataContainer(width, height, context, bookSlotController),
//
//           // buildDatePicker(
//           //   context: context,
//           //   controller: individualDateController,
//           // ),
//           spacer,
//           MyTextFeild(
//             hintText: 'Upload ID',
//             controller: individualUploadIdController,
//             validator: '',
//           ),
//           spacer,
//           CustomButton(
//             text: 'Book Slot',
//             onPressed: () {
//               bookSlotController.addIndividualSlot(
//                 eventId: widget.eventId,
//                 name: individualNameController.text.trim(),
//                 email: individualEmailController.text.trim(),
//                 uploadId: individualUploadIdController.text.trim(),
//               );
//             },
//           )
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
//             controller: organizationNameController,
//           ),
//           spacer,
//           MyTextFeild(
//             hintText: 'Email',
//             controller: organizationEmailController,
//           ),
//           spacer,
//           buildDataContainer(width, height, context, bookSlotController),
//           // buildDatePicker(
//           //   context: context,
//           //   controller: organizationDateController,
//           // ),
//           spacer,
//           MyTextFeild(
//             hintText: 'Company Name',
//             controller: organizationCompanyNameController,
//           ),
//           spacer,
//           MyTextFeild(
//             hintText: 'No. of Pax',
//             controller: organizationPaxController,
//           ),
//           spacer,
//           CustomButton(
//             text: 'Book Slot',
//             onPressed: () {
//               bookSlotController.addOrganizationSlot(
//                 eventId: widget.eventId,
//                 name: organizationNameController.text.trim(),
//                 email: organizationEmailController.text.trim(),
//                 companyName: organizationCompanyNameController.text.trim(),
//                 pax: organizationPaxController.text.trim(),
//               );
//             },
//           )
//         ],
//       ),
//     );
//
//     return ReusableBackGroundScreen(
//       tabTitles: ["Individual", "Organization"],
//       tabViews: [
//         SingleChildScrollView(child: individual),
//         SingleChildScrollView(child: organization)
//       ],
//       isBookSlot: true,
//       appBarTitle: 'Book Slot',
//     );
//   }
//
//   Widget buildDataContainer(double width, double height, BuildContext context,
//       BookSlotController controller) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           vertical: height * 0.0065, horizontal: width * 0.035),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Obx(
//             () => Text(
//               controller.selectedDate.value,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: width * 0.035,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () async {
//               DateTime? selectedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2101),
//               );
//               if (selectedDate != null) {
//                 controller.selectedDate.value =
//                     DateFormat('yyyy-MM-dd').format(selectedDate);
//               }
//             },
//             icon: Icon(
//               Icons.calendar_month,
//               size: width * 0.05,
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget buildDatePicker({
//     required BuildContext context,
//     required TextEditingController controller,
//   }) {
//     return GestureDetector(
//       onTap: () async {
//         DateTime? selectedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2100),
//         );
//         if (selectedDate != null) {
//           controller.text = selectedDate.toLocal().toString().split(' ')[0];
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               controller.text.isEmpty ? "Select Date" : controller.text,
//               style: TextStyle(color: Colors.grey),
//             ),
//             Icon(Icons.calendar_today, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose of controllers to prevent memory leaks
//     individualNameController.dispose();
//     individualEmailController.dispose();
//     individualDateController.dispose();
//     individualUploadIdController.dispose();
//     organizationNameController.dispose();
//     organizationEmailController.dispose();
//     organizationCompanyNameController.dispose();
//     organizationPaxController.dispose();
//     super.dispose();
//   }
// }
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
