import 'package:flutter/material.dart';
import 'package:flutter_ielts/reading/reading_content.dart';

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              // for (int index = 0; index < mockQuestions.length; index++)
              //   ListTile(
              //     title: Text(mockQuestions[index].question),
              //   )

              ...List.generate(
                  mockQuestions.length,
                  (index) => ListTile(
                        title: Text(mockQuestions[index].question),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
