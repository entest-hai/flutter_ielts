import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math' as math;
import 'reading_content.dart';
import 'question.dart';

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
                  _readingProgressBar(context),
                  _readingContent(),
                  QuestionView(
                    questions: sampleQuestions,
                  )
                ],
              ),
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: QuestionView(
              //     questions: sampleQuestions,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Reading content
  Widget _readingContent() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: SingleChildScrollView(
        child: Center(
          child: Text(readingcontent),
        ),
      ),
    ));
  }

  // Reading progress bar
  Widget _readingProgressBar(BuildContext context) {
    return Container(
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
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
                  value: 0.5,
                  minHeight: 6,
                ),
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.person), onPressed: () {})
        ],
      ),
    );
  }
}

// QuestionView with collapsable
class QuestionView extends StatefulWidget {
  final List<QuestionModel> questions;
  const QuestionView({Key key, this.questions}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _QuestionViewState();
  }
}

class _QuestionViewState extends State<QuestionView> {
  bool _hidden = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.cyan,
      height: _hidden ? 50 : 300,
      width: MediaQuery.of(context).size.width,
      child: _questionSlider(widget.questions, _hidden),
    );
  }

  Widget _questionSlider(List<QuestionModel> questions, bool hidden) {
    return CarouselSlider(
      options: CarouselOptions(
          height: hidden ? 50 : MediaQuery.of(context).size.height / 3.0,
          viewportFraction: 1.0,
          enlargeCenterPage: true),
      items: questions.map((question) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              color: Colors.grey,
              child: _questionCard(question, hidden),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _questionCard(QuestionModel question, bool hidden) {
    return Container(
      // color: Colors.cyan,
      // height: _hidden ? 50 : 300,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _questionSubmitBar(),
          Expanded(
              child: Container(
            color: Colors.grey[200],
            child: widget.questions == null
                ? null
                : _questionView(widget.questions[0], hidden),
          ))
        ],
      ),
    );
  }

  Widget _questionView(QuestionModel question, bool hidden) {
    return ListView(
      children: [
        Card(
          elevation: 0,
          color: Colors.grey,
          child: ListTile(
            title: Text(
              question.question,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              print("tap question");
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              question.optionA,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            onTap: () {
              setState(() {
                question.selected = 0;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color: question.selected == 0 ? Colors.yellow : Colors.white,
        ),
        Card(
          child: ListTile(
            title: Text(question.optionB),
            onTap: () {
              setState(() {
                question.selected = 1;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color: question.selected == 1 ? Colors.yellow : Colors.white,
        ),
        Card(
          child: ListTile(
            title: Text(question.optionC),
            onTap: () {
              setState(() {
                question.selected = 2;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color: question.selected == 2 ? Colors.yellow : Colors.white,
        ),
        Card(
          child: ListTile(
            title: Text(question.optionD),
            onTap: () {
              setState(() {
                question.selected = 3;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color: question.selected == 3 ? Colors.yellow : Colors.white,
        ),
      ],
    );
  }

  Widget _questionSubmitBar() {
    return Container(
      color: Colors.cyan,
      child: Row(
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
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[100],
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
    );
  }
}
