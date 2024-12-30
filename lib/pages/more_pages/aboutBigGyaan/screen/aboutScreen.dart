import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'About',
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
              horizontal: size.width * 0.06,
              vertical: size.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bimagyaan',
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  'We are a group of insurance practitioners from diverse segments, but with one thing in common - a passion to promote learning in insurance! The team has a history of engaging the market with technical expertise and hosting seminars. We this initiative as a means to promote thought leadership in insurance and develop skill sets to promote a vibrant and dynamic insurance community.',
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                _buildProfileCard(
                  context,
                  size,
                  name: 'DR. N. RAVEENDRAN',
                  role: 'Principal Consultant | Xsentinel Pvt Ltd',
                  description:
                      'Dr. Raveendran is a management graduate (UK) and obtained his Ph.D in the field of insurance. He is a certified risk manager and business continuity planner. He has about 5 years of experience in the field of advertising, 9 years in international marketing and 14 years of experience in insurance and risk management. He had created an assessment tool for assessing the capabilities in micro insurance interventions. This tool is currently included as one of the course curriculum in micro insurance institute, London. He has been awarded with many awards and accolades including "Innovation in insurance distribution" and gold star award for CSR achievements for the year 2013.',
                ),
                SizedBox(height: size.height * 0.03),
                _buildProfileCard(
                  context,
                  size,
                  name: 'MR. SURESH B',
                  role: 'Reinsurance Expert',
                  description:
                      'Mr. Suresh Balakrishnan is working an independent as risk management and risk transfer advisor. He has been a specialist broker for liability and high value risks. He serves as guest faculty at the national insurance academy, Pune on liability insurance. His expertise includes largest directors and officers liability insurance and P&I insurance; single project professional indemnity policies including ports, airports and metro rail up to 12 year policy periods; FI, construction and technology domains. He worked as reinsurance broker handling both treaty and facultative reinsurance placements for a technology company for new India assurance.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    Size size, {
    required String name,
    required String role,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(size.width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: size.width * 0.02,
            offset: Offset(0, size.width * 0.005),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: size.width * 0.23,
                  height: size.width * 0.23,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(size.width * 0.065),
                    child: Image.asset(
                      "lib/assets/Rectangle 32.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              // CircleAvatar(
              //   radius: size.width * 0.08,
              //   backgroundImage: AssetImage('assets/person_placeholder.png'),
              // ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: size.width * 0.035,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
