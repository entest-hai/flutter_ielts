import 'package:flutter_bloc/flutter_bloc.dart';
import 'wordcard_state.dart';
import 'wordcard_event.dart';
import 'wordcard_repository.dart';

class WordCardsBloc extends Bloc<WordCardsEvent, WordCardsState> {
  final _wordCardRepository = WordCardRepository(cards: []);
  WordCardsBloc() : super(LoadingWordCardsState());

  @override
  Stream<WordCardsState> mapEventToState(WordCardsEvent event) async* {
    final cards = _wordCardRepository.cards;

    if (event is AddCardEvent) {
      print("add event ${cards.length}");
      cards.add(event.card);
      yield LoadedWordCardsState(cards: cards);
    }

    if (event is LoadWordCardsEvent) {
      yield LoadingWordCardsState();
      try {
        print("load event");
        yield LoadedWordCardsState(cards: cards);
      } catch (e) {
        yield FailedToLoadWordCardsState(error: e);
      }
    }
  }
}
