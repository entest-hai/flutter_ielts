import 'question.dart';

class ReadingAnswersState {
  final bool submitted;
  final int numQuestionsAnswered;
  final List<Question> questions;

  ReadingAnswersState({
    this.submitted = false,
    numQuestionsAnswered,
    questions,
  })  : this.numQuestionsAnswered = numQuestionsAnswered ?? 0,
        this.questions = questions ?? [];
}
