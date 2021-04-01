import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math' as math;
import 'reading_content.dart';
import 'question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// reading questions state and cubit
import 'reading_questions_cubit.dart';
import 'reading_questions_state.dart';
// import reading answers and cubit
import 'reading_answers_cubit.dart';
import 'reading_answers_state.dart';

class ReadingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ReadingAnswersCubit()),
          BlocProvider(
              create: (context) => ReadingQuestionsCubit(
                  readingAnswersCubit: context.read<ReadingAnswersCubit>())
                ..loadReadingQuestions()),
        ],
        child: ReadingNavigator(),
      ),
    );
  }
}

// Reading app navigator
class ReadingNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [MaterialPage(child: ReadingView())],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}

class ReadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ReadingQuestionsCubit, ReadingQuestionsState>(
          builder: (context, state) {
            if (state is ReadingQuestionsLoadedSuccess) {
              return Stack(
                children: [
                  Column(
                    children: [
                      _readingProgressBar(context),
                      _readingContent(),
                      QuestionView(
                        questions: state.questions,
                      )
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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
  final List<Question> questions;
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

  Widget _questionSlider(List<Question> questions, bool hidden) {
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
              child: _questionCard(
                  question, hidden, questions.indexOf(question) + 1),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _questionCard(Question question, bool hidden, int questionIndex) {
    return Container(
      // color: Colors.cyan,
      // height: _hidden ? 50 : 300,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _questionSubmitBar(questionIndex),
          Expanded(
              child: Container(
            color: Colors.grey[200],
            child: widget.questions == null
                ? null
                : _questionView(question, hidden),
          ))
        ],
      ),
    );
  }

  Widget _questionView(Question question, bool hidden) {
    return BlocBuilder<ReadingAnswersCubit, ReadingAnswersState>(
        builder: (context, state) {
      return ListView(
        children: [
          Card(
            elevation: 0,
            color: Colors.grey[200],
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
          ...question.options.map((e) => Card(
                child: ListTile(
                  title: Text(
                    'Option $e',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    // able to submite when answered all questions
                    BlocProvider.of<ReadingAnswersCubit>(context).updateAnswer(
                        widget.questions.indexOf(question),
                        question.options.indexOf(e));
                  },
                ),
                color: question.selections[question.options.indexOf(e)]
                    ? Colors.yellow[800]
                    : Colors.white,
              )),
        ],
      );
    });
  }

  Widget _questionSubmitBar(int questionIndex) {
    return BlocBuilder<ReadingAnswersCubit, ReadingAnswersState>(
        builder: (context, state) {
      return Container(
        color: Colors.cyan,
        child: Row(
          children: [
            Transform.rotate(
              angle: 270 * math.pi / 180,
              child: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
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
              "Question $questionIndex/${widget.questions.length}",
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
                      elevation: state.submitted ? 10 : 0,
                      primary:
                          state.submitted ? Colors.white : Colors.grey[300],
                      padding: EdgeInsets.only(left: 5, right: 5)),
                  onPressed: () {
                    BlocProvider.of<ReadingAnswersCubit>(context).submit();
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: state.submitted
                            ? Colors.blueGrey[800]
                            : Colors.grey[800]),
                  )),
            ),
          ],
        ),
      );
    });
  }
}
