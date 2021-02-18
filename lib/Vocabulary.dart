import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VocabularyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<WordCardsBloc>(
        create: (context) => WordCardsBloc()..add(AddCardEvent()),
        child: VocalbularyNavigator(),),
    );
  }
}

class VocalbularyNavigator extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<WordCardsBloc, WordCardsState>(
      builder: (context, cards) {
        return Navigator(
          pages: [
            MaterialPage(child: VocabularyView())
          ],
          onPopPage: (route, result) {

          },
        );
      },
    );
  }
}

class VocabularyView extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _VocabularyView();
}

class _VocabularyView extends State<VocabularyView> {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Desk"),),
      body: BlocBuilder<WordCardsBloc, WordCardsState>(
        builder: (context, state) {
          if (state is LoadingWordCardsState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedWordCardsState) {
            return ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(title: Text(state.cards[index].word),),
                );
              }
              );
          } else {
            return Center(
              child: Text("Error occured"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WordCardView())
            ),
        },
      ),
    );
  }
}

class WordCardView extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _WordCardState();
}

class _WordCardState extends State<WordCardView> {
  @override 
  Widget build(BuildContext context){
    return BlocBuilder<WordCardsBloc, WordCardsState>(
      builder: (context, cards) {
        return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              BlocProvider.of<WordCardsBloc>(context).add(AddCardEvent());
            }
            )
        ],
        ),
      body: Column(
        children: [
          Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: "New Word",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)))
              ),
            ),
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)))
              ),
                
            ),
          )
        ],
      ),
    );
      },
    );
  }
}

class WordCard {
  final String word;
  final String description;
  WordCard({this.word, this.description});
}

class DataService {
  List<WordCard> cards = [
    WordCard(word: "professional", description: "something requires take a long time"),
    WordCard(word: "level", description: "indicate strength of something"),
    WordCard(word: "retrieve", description: "get something from something"),
    WordCard(word: "extract", description: "get or refine thing from something")
  ];

  List<WordCard> getWordCards() {
    return cards;
  }
}

abstract class WordCardsEvent {}

abstract class WordCardsState {}


class LoadWordCardsEvent extends WordCardsEvent {}

class LoadingWordCardsState extends WordCardsState {}

class AddCardEvent extends WordCardsEvent {}

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

class WordCardsBloc extends Bloc<WordCardsEvent, WordCardsState> {
  final _dataService = DataService();
  WordCardsBloc() : super(LoadingWordCardsState());

  @override
  Stream<WordCardsState> mapEventToState(WordCardsEvent event) async* {
    if (event is AddCardEvent){
      var cards = _dataService.getWordCards();
      cards.add(WordCard(word: "New", description: "something"));
      yield LoadedWordCardsState(cards: cards);
    }

    if (event is LoadWordCardsEvent) {
      yield LoadingWordCardsState();
      try {
        final cards = _dataService.getWordCards();
        yield LoadedWordCardsState(cards: cards);
      } catch (e) {
        yield FailedToLoadWordCardsState(error: e);
      }
    }
  }

}

