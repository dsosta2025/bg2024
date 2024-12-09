import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RescheduleAppoitment extends StatelessWidget {
  const RescheduleAppoitment({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    TextEditingController textEditingController = TextEditingController();

    var spacer = SizedBox(
      height: height * 0.03,
    );

    return ReusableBackGroundScreen(
      appBarTitle: 'Schedule appointment',
      singleView: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.03, horizontal: width * 0.05),
        child: Column(
          children: [
            spacer,
            buildDataContainer(width, height),
            spacer,
            MyTextFeild(
              hintText: 'Subject',
              controller: textEditingController,
            ),
            spacer,
            MyTextFeild(
              hintText: 'Description',
              controller: textEditingController,
            ),
            spacer,
            MyTextFeild(
              hintText: 'Meeting link (optional)',
              controller: textEditingController,
            ),
            spacer,
            MyTextFeild(
              hintText: 'Meeting Venue (optional).',
              controller: textEditingController,
            ),
            spacer,
            spacer,
            CustomButton(text: 'Schedule', onPressed: () {})
          ],
        ),
      ),
    );
  }

  Widget buildDataContainer(double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.0065, horizontal: width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Date",
            style: TextStyle(
              color: Colors.grey,
              fontSize: width * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.calendar_month,
                size: width * 0.05,
              ))
        ],
      ),
    );
  }
}
