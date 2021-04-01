import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'reading_content.dart';

class ReadingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.cyan.withOpacity(0.0),
                    height: 50,
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Expanded(
                          child: Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                                value: 0.5,
                                minHeight: 6,
                              ),
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.person), onPressed: () {})
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Text(readingcontent),
                      ),
                    ),
                  ))
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: QuestionView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
class ReadingProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: Colors.cyan,
    );
  }
}

// QuestionView with collapsable
class QuestionView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuestionViewState();
  }
}

class _QuestionViewState extends State<QuestionView> {
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      height: _hidden ? 50 : 300,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Transform.rotate(
                angle: 270 * math.pi / 180,
                child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.blue,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidden = !_hidden;
                      });
                    }),
              ),
              Spacer(),
              Text(
                "Question 1/11",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey[300],
                        padding: EdgeInsets.only(left: 5, right: 5)),
                    onPressed: () {},
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )),
              ),
            ],
          ),
          Expanded(child: Container(color: Colors.grey[200]))
        ],
      ),
    );
  }
}
