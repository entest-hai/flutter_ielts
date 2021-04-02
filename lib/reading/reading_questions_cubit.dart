import 'package:flutter_bloc/flutter_bloc.dart';
import 'reading_questions_state.dart';
import 'reading_content.dart';
import 'reading_answers_cubit.dart';

class ReadingQuestionsCubit extends Cubit<ReadingQuestionsState> {
  final ReadingAnswersCubit readingAnswersCubit;

  // Load questions from DB
  ReadingQuestionsCubit({this.readingAnswersCubit})
      : super(ReadingQuestionsLoading());

  // Loaded questions from DB
  Future<void> loadReadingQuestions() async {
    await Future.delayed(Duration(seconds: 2));
    emit(ReadingQuestionsLoadedSuccess(questions: mockQuestions));
    readingAnswersCubit.loadQuestions(mockQuestions);
  }

  //
}
