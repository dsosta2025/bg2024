import 'package:bima_gyaan/pages/home_pages/buy_sponsor_section/registor_form_to_Buy_sponsor.dart';
import 'package:bima_gyaan/utils/colors.dart';
import 'package:bima_gyaan/utils/custom_button.dart';
import 'package:bima_gyaan/widgets/rsuable_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuySponsorScreen extends StatelessWidget {
  String eventId;

  BuySponsorScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    TextEditingController textEditingController = TextEditingController();

    var spacer = SizedBox(
      height: height * 0.03,
    );

    final silver = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.01),
        decoration: BoxDecoration(
            color: AppColors.lightPeach,
            borderRadius: BorderRadius.circular(20.r)),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              "Silver Sponsors",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.1,
                  fontWeight: FontWeight.w900,
                  height: height * 0.0011),
            ),
            spacer,
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.012, horizontal: width * 0.05),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.025)),
              child: Text(
                "INR 2,00,000 + 18 % GST",
                style: TextStyle(
                  color: AppColors.orange2,
                  fontSize: width * 0.058,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            spacer,
            SizedBox(
              width: width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Networking",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "You will receive 7 free passes for the Seminar",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                  Text(
                    "Brand Recognition and Positioning",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "Brand Visibility on the Main Event Stage",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Background Display of Standee at the Venue",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                  Text(
                    "Pre-event Brand Awareness",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "One year visibility on BG app ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "(which has a hit ratio of 300 downloads successfully)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.028,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                ],
              ),
            ),
            CustomButton(
                text: 'Buy Silver',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistorFormToBuySponsor(
                          sponserType: 'Silver',
                          eventId: eventId,
                        ),
                      ));
                })
          ]),
        ),
      ),
    );
    final gold = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.01),
        decoration: BoxDecoration(
            color: AppColors.lightPeach,
            borderRadius: BorderRadius.circular(20.r)),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              "Gold Sponsors",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.1,
                  fontWeight: FontWeight.w900,
                  height: height * 0.0011),
            ),
            spacer,
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.012, horizontal: width * 0.05),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.025)),
              child: Text(
                "INR 3,00,000 + 18 % GST",
                style: TextStyle(
                  color: AppColors.orange2,
                  fontSize: width * 0.058,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            spacer,
            SizedBox(
              width: width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Networking",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "You will receive 7 free passes for the Seminar",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                  Text(
                    "Brand Recognition and Positioning",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "Brand Visibility on the Main Event Stage",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Background Display of Standee at the Venue",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                  Text(
                    "Pre-event Brand Awareness",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "One year visibility on BG app ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "(which has a hit ratio of 300 downloads successfully)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.028,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                ],
              ),
            ),
            CustomButton(
                text: 'Buy Gold',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistorFormToBuySponsor(
                          sponserType: "Gold",
                          eventId: eventId,
                        ),
                      ));
                })
          ]),
        ),
      ),
    );
    final platinum = Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.01),
        decoration: BoxDecoration(
            color: AppColors.lightPeach,
            borderRadius: BorderRadius.circular(20.r)),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              "Platinum\nSponsors",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.1,
                  fontWeight: FontWeight.w900,
                  height: height * 0.0011),
            ),
            spacer,
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.012, horizontal: width * 0.05),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.025)),
              child: Text(
                "INR 5,00,000 + 18 % GST",
                style: TextStyle(
                  color: AppColors.orange2,
                  fontSize: width * 0.058,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            spacer,
            SizedBox(
              width: width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Networking",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "You will receive 7 free passes for the Seminar",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                  Text(
                    "Brand Recognition and Positioning",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "Brand Visibility on the Main Event Stage",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Background Display of Standee at the Venue",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                  Text(
                    "Pre-event Brand Awareness",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    "One year visibility on BG app ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "(which has a hit ratio of 300 downloads successfully)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.028,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: AppColors.orange2,
                  ),
                  spacer,
                ],
              ),
            ),
            CustomButton(
                text: 'Buy Platinum',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistorFormToBuySponsor(
                          sponserType: "Platinum",
                          eventId: eventId,
                        ),
                      ));
                })
          ]),
        ),
      ),
    );

    return ReusableBackGroundScreen(
      tabTitles: ["Platinum", "Gold", 'Silver'],
      tabViews: [platinum, gold, silver],
      isBookSlot: true,
      appBarTitle: 'Buy sponsorship',
    );
  }
}
