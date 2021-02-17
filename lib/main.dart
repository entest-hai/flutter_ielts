import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ielts/constants.dart';
import 'dart:math' as math;
import 'Product.dart';

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
      home: HomePageView()
    );
  }
}

// HomePageView with GridView 
class HomePageView extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageView> {
  @override 
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

   AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.person,
          size: 20,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {}
            ),
        IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {}),
        SizedBox(width: kDefaultPaddin / 2 ,)
      ],
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Text("IELTS",
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.bold),
        )
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75
                ),
                itemBuilder: (context, index) => ItemCard(
                  product: products[index],
                  press: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => ReadingView()
                    )
                  ),
                )
            ),
          ),
        ),
      ],
    );
  }
}

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Reading", "Listening", "Writting", "Full Test", "Vocabulary"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
        child: SizedBox(
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index)),
    ),
    );
  }

  Widget buildCategory(int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Image.asset(product.image),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
              child: Text(
                product.title,
                style: TextStyle(
                    color: kTextLightColor
                ),
              )
          ),
          Text("\$${product.price}", style: TextStyle(
            fontWeight: FontWeight.bold,

          ),)
        ],
      ),
    );
  }
}


// Reading View 
class ReadingView extends StatefulWidget {
  @override 
  _ReadingViewState createState() => _ReadingViewState();
}

// Reading View State with QuestionModel Data 
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
    ),
    QuestionModel(
      question: "Why AWS is so popular today?",
      optionA: "Mature",
      optionB: "Friendly",
      optionC: "Professional",
      optionD: "Cheap",
      selected: -1
    ),
    QuestionModel(
      question: "Where is saftest place on earth?",
      optionA: "Japan",
      optionB: "United State",
      optionC: "Vietnam",
      optionD: "North Korea",
      selected: -1
    )
  ];

  @override 
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size; 
    return Scaffold(
      body: SafeArea(
              child: Column(
          children: [
            _QuitReadingView(size),
            _ReadingContentView(size),
            _QuestionBar(isHidden),
           _QuestionPageView(size, isHidden),
          ],
        ),
      )
    );
  }

  // Back To HomePageView 
  Widget _QuitReadingView(size) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          }
          ),
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
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {}
           ) 
      ],
    );
  }

  // Create QuestionView with Question and Option 
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

  // Create QuestionPageView with Horizontal ScollView Per Page 
  Widget _QuestionPageView(size, isHidden){
    return  Container(
      width: size.width,
      height: isHidden ? 0 : size.height / 2.5,
      child: PageView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            child: _QuestionView(questions[index]),
          );
        },
      )
    );
  }

  // Create QuestionBar with Hiden Button to Expand Reading Content 
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
                onPressed: () => Navigator.pop(context),
                child: Text("Submit", style: TextStyle(
                  color: Colors.white
                ),)) 
                
            ],),
          );
  }

  // ReadingContentView with Scroll Vertically 
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
              color: Colors.black
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

// QuestionModel 
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