import 'package:flutter_bloc/flutter_bloc.dart';
import 'reading_question.dart';
import 'reading_answers_state.dart';

class ReadingAnswersCubit extends Cubit<ReadingAnswersState> {
  List<Question> questions = [];
  ReadingAnswersCubit() : super(ReadingAnswersState(numQuestionsAnswered: 0));

  // Load questions
  void loadQuestions(List<Question> questions) {
    print("questions loaded for answers cubit");
    emit(ReadingAnswersState(
        submitted: false,
        questions: questions,
        numQuestionsAnswered: 0,
        correctOptions: List.generate(questions.length + 1, (index) => -1)));
  }

  // Update an answer
  void updateAnswer(int questionIdx, int optionIdx) {
    questions = this.state.questions;

    // update selections
    questions[questionIdx].selections[optionIdx] =
        !questions[questionIdx].selections[optionIdx];

    // question answered
    questions[questionIdx].answered = false;
    for (var selection in questions[questionIdx].selections) {
      if (selection) {
        questions[questionIdx].answered = true;
        break;
      }
    }

    // number of question answered
    var numAnsweredQuestion = 0;
    for (var question in questions) {
      if (question.answered) {
        numAnsweredQuestion += 1;
      }
    }

    print("num answered question $numAnsweredQuestion");

    emit(ReadingAnswersState(
        questions: questions,
        numQuestionsAnswered: numAnsweredQuestion,
        submitted:
            numAnsweredQuestion >= this.state.questions.length ? true : false,
        correctOptions: this.state.correctOptions));
  }

  // Todo submit answers to cloud
  Future<void> submit() async {
    if (this.state.numQuestionsAnswered >= this.state.questions.length) {
      // submit answers to cloud
      print("submitted answers to cloud");

      emit(ReadingAnswersState(
          questions: this.state.questions,
          submitted: false,
          correctOptions: this.state.correctOptions));

      // wait for results
      await Future.delayed(Duration(seconds: 2));
      final corrects =
          List.generate(this.state.questions.length + 1, (index) => index);
      emit(ReadingAnswersState(
          questions: this.state.questions,
          submitted: false,
          correctOptions: corrects));
    }
  }
}
