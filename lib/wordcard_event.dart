import 'wordcard_state.dart';
import 'wordcard.dart';

class AddCardEvent extends WordCardsEvent {
  final WordCard card;
  AddCardEvent({this.card});
}

class AddCardState extends WordCardsState {
  List<WordCard> cards;
  AddCardState({this.cards});
}

class LoadedWordCardsState extends WordCardsState {
  List<WordCard> cards;
  LoadedWordCardsState({this.cards});
}

class FailedToLoadWordCardsState extends WordCardsState {
  Error error;
  FailedToLoadWordCardsState({this.error});
}
