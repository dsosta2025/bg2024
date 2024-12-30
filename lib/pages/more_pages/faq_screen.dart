import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Item> _items = [
    Item(
        header:
            'If you could change careers right this second, what would you do?',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
    Item(
        header:
            'Which of the Seven Wonders of the world do you want to visit the most?',
        content: 'Details about Seven Wonders.'),
    Item(
        header: 'What makes you happiest?',
        content: 'Things that make you happy.'),
    Item(
        header:
            'What did you say as a kid when asked: What do you want to be when you grow up?',
        content: 'Your childhood dream.'),
    Item(
        header: 'If you could visit one planet, which would it be?',
        content: 'Details about your preferred planet.'),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
        height: screenHeight,
        padding: EdgeInsets.only(top: screenHeight * 0.015),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.1),
                topRight: Radius.circular(screenWidth * 0.1))),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 16),
            child: Column(
              children: [
                ..._items.map((item) => FAQItemWidget(item: item)).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FAQItemWidget extends StatefulWidget {
  final Item item;

  FAQItemWidget({required this.item});

  @override
  _FAQItemWidgetState createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Card(
      color: AppColors.lightPeach,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.item.header,
              style: TextStyle(
                  fontSize: width * 0.045, fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  color: AppColors.orange2),
              child: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.item.content,
                style: TextStyle(fontSize: width * 0.04),
              ),
            ),
        ],
      ),
    );
  }
}

class Item {
  final String header;
  final String content;

  Item({
    required this.header,
    required this.content,
  });
}
