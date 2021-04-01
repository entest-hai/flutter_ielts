import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ielts/question.dart';
import 'reading_answers_state.dart';
import 'question.dart';

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
        correctOptions: List.generate(questions.length, (index) => -1)));
  }

  // Update an answer
  void updateAnswer(int questionIdx, int optionIdx) {
    questions = this.state.questions;
    questions[questionIdx].selections[optionIdx] =
        !questions[questionIdx].selections[optionIdx];
    emit(ReadingAnswersState(
        questions: questions,
        numQuestionsAnswered: this.state.numQuestionsAnswered + 1,
        submitted:
            this.state.numQuestionsAnswered + 1 >= this.state.questions.length
                ? true
                : false,
        correctOptions: this.state.correctOptions));
  }

  // Todo submit answers to cloud
  Future<void> submit() async {
    if (this.state.numQuestionsAnswered >= this.state.questions.length) {
      // submit answers to cloud
      print("submitted answers to cloud");
      await Future.delayed(Duration(seconds: 2));
      final corrects =
          List.generate(this.state.questions.length, (index) => index);
      emit(ReadingAnswersState(correctOptions: corrects));
    }
  }
}
