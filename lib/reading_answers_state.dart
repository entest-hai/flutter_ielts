import 'answer.dart';

class ReadingAnswersState {
  final bool submitted;
  final int numQuestionsAnswered;
  final List<ReadingAnswer> answers;

  ReadingAnswersState({
    this.submitted = false,
    numQuestionsAnswered,
    answers,
  })  : this.numQuestionsAnswered = numQuestionsAnswered ?? 0,
        this.answers = answers ?? [];
}
