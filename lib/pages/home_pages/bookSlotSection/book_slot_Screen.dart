import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/customeButton.dart';
import 'package:bima_gyaan/widgets/customeTextField.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookSlotScreen extends StatefulWidget {
  const BookSlotScreen({super.key});

  @override
  State<BookSlotScreen> createState() => _BookSlotScreenState();
}

class _BookSlotScreenState extends State<BookSlotScreen> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    TextEditingController textEditingController = TextEditingController();

    var spacer = SizedBox(
      height: height * 0.03,
    );

    final individual = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Column(
        children: [
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
          buildDataContainer(width, height),
          spacer,
          MyTextFeild(
            hintText: 'Uplode Id',
            controller: textEditingController,
          ),
          spacer,
          CustomButton(text: 'Make Payment', onPressed: () {})
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
            controller: textEditingController,
          ),
          spacer,
          MyTextFeild(
            hintText: 'Email',
            controller: textEditingController,
          ),

          spacer,
          buildDataContainer(width, height),
          spacer,
          MyTextFeild(
            hintText: 'company Name',
            controller: textEditingController,
          ),
          spacer,
          MyTextFeild(
            hintText: 'no. of pax',
            controller: textEditingController,
          ),
          spacer,
          CustomButton(text: 'Make Payment', onPressed: () {})
        ],
      ),
    );

    return ReusableBackGroundScreen(
      tabTitles: [
        "Individual",
        "Organization",
      ],
      tabViews: [
        individual,
        organization,
      ],
      isBookSlot: true,
      appBarTitle: 'Book Slot',
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
