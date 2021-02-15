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

  Widget _QuestionView(){
    return ListView(
      children: [
        Card(
          color: Colors.white,
          child: ListTile(
            title: Text("Question"),
          )
          ),
        Card(
          color: Colors.amber[600],
          child: ListTile(
            title: Text("Option A"),
          )
          ),
        Card(
          color: Colors.amber[600],
          child: ListTile(
            title: Text("Option B"),
          )
          ),
        Card(
          color: Colors.amber[600],
          child: ListTile(
            title: Text("Option C"),
          )
          ),
        Card(
          color: Colors.amber[600],
          child: ListTile(
            title: Text("Option D"),
          )
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
            child: _QuestionView(),
          )
          ,
          Container(
            color: Colors.grey,
            child: _QuestionView(),
          ),
        ],
      ),
    );
  }

  Widget _OptionViewA(size, isHidden) {
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(microseconds: 200),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 200),
        width: size.width,
        alignment: Alignment.topCenter,
        height: isHidden ? 0 : size.height / 3.5,
        child: CategoriesScroller(),
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
            child: Text("Reading Content"),
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



class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();
  @override 
  Widget build(BuildContext context){
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50; 
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Most\nFavorites", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Newest",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Newest",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}