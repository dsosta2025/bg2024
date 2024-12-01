import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistorFormToBuySponsor extends StatelessWidget {
  const RegistorFormToBuySponsor({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    TextEditingController textEditingController = TextEditingController();

    var spacer = SizedBox(
      height: height * 0.03,
    );

    return ReusableBackGroundScreen(
      appBarTitle: 'Buy sponsorship',
      isBookSlot: true,
      singleView: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.03, horizontal: width * 0.05),
        child: Column(
          children: [
            spacer,
            MyTextFeild(
              hintText: 'Name',
              controller: textEditingController,
            ),
            spacer,
            MyTextFeild(
              hintText: 'Email',
              controller: textEditingController,
            ),
            spacer,
            MyTextFeild(
              hintText: 'company Name',
              controller: textEditingController,
            ),
            spacer,
            MyTextFeild(
              hintText: 'Company GST no.',
              controller: textEditingController,
            ),
            spacer,
            buildDataContainer(width, height),
            spacer,
            CustomButton(text: 'Make Payment', onPressed: () {})
          ],
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
