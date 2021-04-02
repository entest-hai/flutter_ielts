import 'package:flutter_bloc/flutter_bloc.dart';
import 'synonym_state.dart';
import 'synonym_repository.dart';

class SynonymCubit extends Cubit<SynonymState> {
  SynonymRepository _synonymRepository = SynonymRepository();
  SynonymCubit() : super(LoadingSynonym());

  void fetchSynonym(String word) async {
    final synonym = await _synonymRepository.fetchSynonym();
    emit(LoadedSynonymSuccess(synonym: synonym));
  }
}
