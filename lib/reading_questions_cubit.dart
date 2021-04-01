import 'package:flutter_bloc/flutter_bloc.dart';
import 'reading_questions_state.dart';
import 'reading_content.dart';

class ReadingQuestionsCubit extends Cubit<ReadingQuestionsState> {
  // Load questions from DB
  ReadingQuestionsCubit() : super(ReadingQuestionsLoading());

  // Get number of questions
  int getNumQuestion() {
    return 5;
  }

  // Loaded questions from DB
  Future<void> loadReadingQuestions() async {
    await Future.delayed(Duration(seconds: 2));
    emit(ReadingQuestionsLoadedSuccess(questions: mockQuestions));
  }

  //
}
