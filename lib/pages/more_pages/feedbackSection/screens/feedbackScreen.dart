import 'package:bima_gyaan/pages/more_pages/feedbackSection/controller/feedbackController.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackScreen extends StatelessWidget {
  final FeedbackController controller = Get.put(FeedbackController());
  final String eventId;

  FeedbackScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: screenWidth * 0.07,
          ),
        ),
        toolbarHeight: screenHeight * 0.1,
      ),
      body: Container(
        padding: EdgeInsets.only(top: screenHeight * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.1),
            topRight: Radius.circular(screenWidth * 0.1),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionCard(
                    context,
                    '1. How would you rate the overall quality of the seminar?',
                    ['Excellent', 'Very Good', 'Good', 'Fair', 'Poor'],
                    (value) => controller.question1Answer.value = value,
                    groupValue: controller.question1Answer.value,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '2. Did the seminar meet your expectation?',
                    [
                      'Exceeded Expectations',
                      'Met Expectations',
                      'Did not meet',
                    ],
                    (value) => controller.question2Answer.value = value,
                    groupValue: controller.question2Answer.value,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '3. What were the things you liked about the seminar contents? (Tick all applicable)',
                    [
                      'Presentation Format',
                      'Speakers Profile',
                      'Topics',
                      'Conference Arrangements & Venue',
                    ],
                    (value) {
                      if (controller.question3Answers.contains(value)) {
                        controller.question3Answers.remove(value);
                      } else {
                        controller.question3Answers.add(value);
                      }
                    },
                    isCheckbox: true,
                    selectedValues: controller.question3Answers,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildOpenTextCard(
                    context,
                    '4. What could we have done better, in your opinion?',
                    controller.question4Answer,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '5. Did you attend the seminar to:',
                    [
                      'Learning Experience',
                      'Make Marketing Contacts',
                      'Network with Peers',
                      'Others, please specify:',
                    ],
                    (value) => controller.question5Answer.value = value,
                    groupValue: controller.question5Answer.value,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '6. What is your key takeaway from the seminar?',
                    [
                      'Learning Experience',
                      'Awareness of Challenges in the Insurance Industry',
                      'Networking Opportunities',
                      'Any Other: Please specify',
                    ],
                    (value) {
                      if (controller.question6Answers.contains(value)) {
                        controller.question6Answers.remove(value);
                      } else {
                        controller.question6Answers.add(value);
                      }
                    },
                    isCheckbox: true,
                    selectedValues: controller.question6Answers,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '7. Are there any topics that you would recommend for the next seminar?',
                    [
                      'Reputation Injury Liability',
                      'Title Insurance',
                      'Weather Derivatives and Other Products',
                      'Any Other: Please specify',
                    ],
                    (value) {
                      if (controller.question7Answers.contains(value)) {
                        controller.question7Answers.remove(value);
                      } else {
                        controller.question7Answers.add(value);
                      }
                    },
                    isCheckbox: true,
                    selectedValues: controller.question7Answers,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildOpenTextCard(
                    context,
                    '8. How did you find the Q&A interaction with panel members?',
                    controller.question8Answer,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildOpenTextCard(
                    context,
                    '9. We would greatly appreciate if you could write a short testimonial on the seminar.',
                    controller.question9Answer,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '10. Did you attend previous BIMA Gyaan events?',
                    ['Last Year', 'Last 2 Years', 'Last 3 Years'],
                    (value) => controller.question10Answer.value = value,
                    groupValue: controller.question10Answer.value,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '11. How would you rate this event compared to last year?',
                    [
                      'Excellent',
                      'Very Good',
                      'Good',
                      'Fair',
                      'Attending First Time',
                    ],
                    (value) => controller.question11Answer.value = value,
                    groupValue: controller.question11Answer.value,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '12. How would you rate the arrangements?',
                    [
                      'Excellent',
                      'Very Good',
                      'Good',
                      'Fair',
                      'Poor',
                    ],
                    (value) => controller.question12Answer.value = value,
                    groupValue: controller.question12Answer.value,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildQuestionCard(
                    context,
                    '13. How would you like the venue for next year?',
                    ['Prefer Same Venue', 'Prefer Different Venue'],
                    (value) => controller.question13Answer.value = value,
                    groupValue: controller.question13Answer.value,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                        : Center(
                            child: CustomeButton(
                            text: "Submit",
                            onPressed: () async {
                              await controller.submitFeedback(eventId);
                              Get.back();
                            },
                          )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    BuildContext context,
    String question,
    List<String> options,
    Function(String) onChanged, {
    String? groupValue,
    bool isCheckbox = false,
    RxList<String>? selectedValues,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      color: AppColors.lightPeach,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            for (var option in options)
              Row(
                children: [
                  isCheckbox
                      ? Checkbox(
                          activeColor: Colors.orange,
                          value: selectedValues?.contains(option) ?? false,
                          onChanged: (value) => onChanged(option),
                        )
                      : Radio(
                          activeColor: Colors.orange,
                          value: option,
                          groupValue: groupValue,
                          onChanged: (value) => onChanged(value!),
                        ),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpenTextCard(
      BuildContext context, String question, RxString answer) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      color: AppColors.lightPeach,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) => answer.value = value,
              decoration: const InputDecoration(
                hintText: 'Write your response here',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

// class FeedbackScreen extends StatelessWidget {
//   String eventId;
//   final FeedbackController controller = Get.put(FeedbackController());
//
//   FeedbackScreen({super.key, required this.eventId});
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text(
//           'Feedback',
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//             size: screenWidth * 0.07,
//           ),
//         ),
//         toolbarHeight: screenHeight * 0.1,
//       ),
//       body: Container(
//         padding: EdgeInsets.only(top: screenHeight * 0.015),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(screenWidth * 0.1),
//                 topRight: Radius.circular(screenWidth * 0.1))),
//         child: SingleChildScrollView(
//           child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.05,
//                 vertical: screenHeight * 0.02,
//               ),
//               child: Obx(
//                 () => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildQuestionCard(
//                       context,
//                       '1. How would you rate the overall quality of the seminar?',
//                       ['Excellent', 'Very good', 'Good', 'Fair', 'Poor'],
//                       (value) => controller.question1Answer.value = value,
//                       groupValue: controller.question1Answer.value,
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                     _buildQuestionCard(
//                       context,
//                       '2. Did the seminar meet your expectation?',
//                       [
//                         'Exceeded expectations',
//                         'Met expectations',
//                         'Did not meet'
//                       ],
//                       (value) => controller.question2Answer.value = value,
//                       groupValue: controller.question2Answer.value,
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                     _buildQuestionCard(
//                       context,
//                       '3. What were the things you liked about the seminar contents? (tick all applicable)',
//                       [
//                         'Presentation format',
//                         'Speakers Profile',
//                         'Topics',
//                         'Conference arrangement & venue',
//                       ],
//                       (value) {
//                         if (controller.question3Answers.contains(value)) {
//                           controller.question3Answers.remove(value);
//                         } else {
//                           controller.question3Answers.add(value);
//                         }
//                       },
//                       isCheckbox: true,
//                       selectedValues: controller.question3Answers,
//                     ),
//                     SizedBox(height: screenHeight * 0.05),
//
//                     Obx(() => controller.isLoading.value
//                         ? const Center(
//                           child: CircularProgressIndicator(
//                               color: AppColors.orange2,
//                             ),
//                         )
//                         : Center(
//                             child: CustomeButton(
//                             text: "Submit",
//                             onPressed: () async {
//                               await controller.submitFeedback(eventId);
//                               Get.back();
//                             },
//                           ))),
//
//                   ],
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuestionCard(
//     BuildContext context,
//     String question,
//     List<String> options,
//     Function(String) onChanged, {
//     String? groupValue,
//     bool isCheckbox = false,
//     RxList<String>? selectedValues,
//   }) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 2,
//       color: AppColors.lightPeach,
//       child: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               question,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: screenWidth * 0.045,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.01),
//             for (var option in options)
//               Row(
//                 children: [
//                   isCheckbox
//                       ? Checkbox(
//                           activeColor: AppColors.orange2,
//                           value: selectedValues?.contains(option) ?? false,
//                           onChanged: (value) => onChanged(option),
//                         )
//                       : Radio(
//                           activeColor: AppColors.orange2,
//                           value: option,
//                           groupValue: groupValue,
//                           onChanged: (value) => onChanged(value!),
//                         ),
//                   Expanded(
//                     child: Text(
//                       option,
//                       style: TextStyle(fontSize: screenWidth * 0.04),
//                     ),
//                   ),
//                 ],
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }
