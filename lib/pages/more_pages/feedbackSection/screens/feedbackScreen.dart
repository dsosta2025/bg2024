import 'package:bima_gyaan/pages/more_pages/feedbackSection/controller/feedbackController.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackScreen extends StatelessWidget {
  String eventId;
  final FeedbackController controller = Get.put(FeedbackController());

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
                topRight: Radius.circular(screenWidth * 0.1))),
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
                      ['Excellent', 'Very good', 'Good', 'Fair', 'Poor'],
                      (value) => controller.question1Answer.value = value,
                      groupValue: controller.question1Answer.value,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildQuestionCard(
                      context,
                      '2. Did the seminar meet your expectation?',
                      [
                        'Exceeded expectations',
                        'Met expectations',
                        'Did not meet'
                      ],
                      (value) => controller.question2Answer.value = value,
                      groupValue: controller.question2Answer.value,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildQuestionCard(
                      context,
                      '3. What were the things you liked about the seminar contents? (tick all applicable)',
                      [
                        'Presentation format',
                        'Speakers Profile',
                        'Topics',
                        'Conference arrangement & venue',
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
                    SizedBox(height: screenHeight * 0.05),

                    Obx(() => controller.isLoading.value
                        ? const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.orange2,
                            ),
                        )
                        : Center(
                            child: CustomeButton(
                            text: "Submit",
                            onPressed: () async {
                              await controller.submitFeedback(eventId);
                              Get.back();
                            },
                          ))),
                    // Center(
                    //   child: SizedBox(
                    //     width: screenWidth * 0.5,
                    //     height: screenHeight * 0.06,
                    //     child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.orange,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20),
                    //         ),
                    //       ),
                    //       onPressed: controller.submitFeedback,
                    //       child: const Text(
                    //         'Submit',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )),
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
                          activeColor: AppColors.orange2,
                          value: selectedValues?.contains(option) ?? false,
                          onChanged: (value) => onChanged(option),
                        )
                      : Radio(
                          activeColor: AppColors.orange2,
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
              )
          ],
        ),
      ),
    );
  }
}
