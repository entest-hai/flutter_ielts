import 'reading_question.dart';

class ReadingAnswersState {
  final bool submitted;
  final int numQuestionsAnswered;
  final List<Question> questions;
  final List<int> correctOptions;

  ReadingAnswersState({
    this.submitted = false,
    numQuestionsAnswered,
    questions,
    correctOptions,
  })  : this.numQuestionsAnswered = numQuestionsAnswered ?? 0,
        this.questions = questions ?? [],
        this.correctOptions = correctOptions ?? [];
}
