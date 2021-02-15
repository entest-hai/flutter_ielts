import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReadingView()
    );
  }
}



// Test Container Height Collapse 
class ReadingView extends StatefulWidget {
  @override 
  _ReadingViewState createState() => _ReadingViewState();
}


class _ReadingViewState extends State<ReadingView> {

  bool isHidden = false;
  List<QuestionModel> questions = [
   QuestionModel(
      question: "What is the highest paid programming language in 2021?",
      optionA: "C++",
      optionB: "C++",
      optionC: "Python",
      optionD: "Flutter",
      selected: -1
    ),
    QuestionModel(
      question: "Where is the best place to work?",
      optionA: "Singapore",
      optionB: "United State",
      optionC: "Israel",
      optionD: "Germany",
      selected: -1
    )
  ];

  @override 
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size; 
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading"),
      ),
      body: Column(
        children: [
          _QuestionBar(isHidden),
         _QuestionPageView(size, isHidden),
          _ReadingContentView(size)
        ],
      )
    );
  }

  Widget _QuestionView(QuestionModel question) {
    return ListView(
      children: [
        Card(
            elevation: 0,
            color: Colors.grey,
            child: ListTile(
            title: Text(
              question.question,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal
              ),
              ),
            onTap: () {
              setState(() {
                question.selected = 0;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color:  question.selected  == 0 ? Colors.yellow : Colors.white,
        ),
       Card(
            child: ListTile(
            title: Text(question.optionB),
            onTap: () {
              setState(() {
                 question.selected  = 1;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color:  question.selected  == 1 ? Colors.yellow : Colors.white,
        ),
        Card(
            child: ListTile(
            title: Text(question.optionC),
            onTap: () {
              setState(() {
                 question.selected  = 2;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color:  question.selected  == 2 ? Colors.yellow : Colors.white,
        ),
        Card(
            child: ListTile(
            title: Text(question.optionD),
            onTap: () {
              setState(() {
                 question.selected  = 3;
              });
              print("tap option answer $question.selected ");
            },
          ),
          color:  question.selected  == 3 ? Colors.yellow : Colors.white,
        ),
        
      ],
    );
  }

  Widget _QuestionPageView(size, isHidden){
    return  Container(
      width: size.width,
      height: isHidden ? 0 : size.height / 3.5,
      child: PageView(
        children: [
          Container(
            color: Colors.grey,
            child: _QuestionView(questions[0]),
          )
          ,
          Container(
            color: Colors.grey,
            child: _QuestionView(questions[1]),
          ),
        ],
      ),
    );
  }


  Widget _QuestionBar(isHidden) {
    return Container(
            color: Colors.cyan,
            child: Row(
              children: [
              IconButton(
                color: Colors.white,
                icon: Transform.rotate(
                  angle: isHidden ? 270 * math.pi / 180 : 90 * math.pi / 180,
                  child: Icon(Icons.chevron_left)),
                iconSize: 24,
                onPressed: collapse),
                
               Expanded(
                 child: Center(child: 
                 Text("Question 1/10", style: TextStyle(
                   fontSize: 15,
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                 ),)),
               ),

              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)
                ),
                onPressed: collapse,
                child: Text("Submit", style: TextStyle(
                  color: Colors.white
                ),)) 
                
            ],),
          );
  }

  Widget _ReadingContentView(size){
    return Expanded(
        child: Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          child: Center(
            child: Text("Reading Content",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.blue
            ),
            ),
          ),
      ),
    );
  }

  void collapse() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}

class QuestionModel {
  final String question; 
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  int selected;
  QuestionModel({
    this.selected,
    this.question,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD});
}