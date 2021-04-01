import 'question.dart';

abstract class ReadingQuestionsState {}

class ReadingQuestionsLoading extends ReadingQuestionsState {}

class ReadingQuestionsLoadedSuccess extends ReadingQuestionsState {
  final List<Question> questions;
  ReadingQuestionsLoadedSuccess({this.questions});
}
