import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ielts/question.dart';
import 'reading_answers_state.dart';
import 'reading_questions_cubit.dart';
import 'reading_questions_state.dart';
import 'answer.dart';

class ReadingAnswersCubit extends Cubit<ReadingAnswersState> {
  final List<ReadingAnswer> answers = [];
  final ReadingQuestionsCubit readingQuestionsCubit;
  ReadingAnswersCubit({this.readingQuestionsCubit})
      : super(ReadingAnswersState(numQuestionsAnswered: 0));

  // Update an answer
  void addAnswer(Question question, String answer) {
    // Form the answer
    final res = ReadingAnswer(
      question: question,
      answer: answer,
    );
    // Update answers
    answers.add(res);
    // Get number of questions from ReadingQuestionsCubit
    // Todo: try catch here
    final numQuestions =
        (readingQuestionsCubit.state as ReadingQuestionsLoadedSuccess)
            .questions
            .length;
    if (this.state.numQuestionsAnswered + 1 >= numQuestions) {
      emit(ReadingAnswersState(
          submitted: true,
          numQuestionsAnswered: this.state.numQuestionsAnswered + 1,
          answers: answers));
    } else {
      emit(ReadingAnswersState(
        numQuestionsAnswered: this.state.numQuestionsAnswered + 1,
        answers: answers,
      ));
    }
  }

  // Submit answers to cloud
  void submit() {
    if (this.state.submitted) {
      print("answer submitted");
      emit(ReadingAnswersState(
        submitted: false,
        numQuestionsAnswered: answers.length,
        answers: answers,
      ));
    }
  }
}
