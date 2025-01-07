import 'package:bima_gyaan/pages/more_pages/qnaSection/controller/qnaController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class QAScreen extends StatelessWidget {
  final QuestionController _controller = Get.put(QuestionController());
  final TextEditingController _questionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller.fetchQuestions();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Questions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_controller.questions.isEmpty) {
                return Center(child: Text('No questions found.'));
              }
              return ListView.builder(
                itemCount: _controller.questions.length,
                itemBuilder: (context, index) {
                  final question = _controller.questions[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.01,
                    ),
                    child: ListTile(
                      title: Text(question['text'] ?? ''),
                      subtitle: Text(
                        question['timestamp'] != null
                            ? (question['timestamp'] as Timestamp).toDate().toString()
                            : 'No timestamp',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_questionController.text.trim().isNotEmpty) {
                      _controller.addQuestion(
                        _questionController.text.trim(),
                        'event123', // Replace with the actual event ID
                      );
                      _questionController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}
