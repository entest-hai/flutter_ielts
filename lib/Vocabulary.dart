import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VocabularyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<WordCardsBloc>(
        create: (context) => WordCardsBloc()..add(LoadWordCardsEvent()),
        child: VocalbularyNavigator(),
        // child: DetailView(),
      ),
    );
  }
}

class VocalbularyNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VocalbularyNavigatorState();
  }
}

class _VocalbularyNavigatorState extends State<VocalbularyNavigator> {
  String _selectedWord;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordCardsBloc, WordCardsState>(
      builder: (context, cards) {
        return Navigator(
          pages: [
            MaterialPage(child: VocabularyView(didSelecteWord: (word) {
              setState(() {
                _selectedWord = word;
              });
            })),
            if (_selectedWord != null) MaterialPage(child: DetailView())
          ],
          onPopPage: (route, result) {
            final page = route.settings as MaterialPage;
            if (page.key == DetailView.valueKey) {
              _selectedWord = null;
            }
            return route.didPop(result);
          },
        );
      },
    );
  }
}

class VocabularyView extends StatefulWidget {
  final didSelecteWord;
  VocabularyView({this.didSelecteWord});
  @override
  State<StatefulWidget> createState() =>
      _VocabularyView(didSelecteWord: didSelecteWord);
}

class _VocabularyView extends State<VocabularyView> {
  final wordController = TextEditingController();
  final descController = TextEditingController();

  final didSelecteWord;
  _VocabularyView({this.didSelecteWord});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desk"),
      ),
      body: BlocBuilder<WordCardsBloc, WordCardsState>(
        builder: (context, state) {
          if (state is LoadingWordCardsState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedWordCardsState) {
            return ListView.builder(
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      didSelecteWord(state.cards[index].word);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(state.cards[index].word),
                      ),
                    ),
                  );
                });
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
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (wordController.text != "") {
                              BlocProvider.of<WordCardsBloc>(context).add(
                                  AddCardEvent(
                                      card: WordCard(
                                          word: wordController.text,
                                          description: descController.text)));
                            }

                            wordController.text = "";
                            descController.text = "";
                            Navigator.pop(context);
                          },
                          child: Text("Save Word")),
                      Container(
                        child: TextField(
                          controller: wordController,
                          decoration: InputDecoration(
                              hintText: "New Word",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                      ),
                      Container(
                        child: TextField(
                          controller: descController,
                          decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                      )
                    ],
                  ),
                );
              })
        },
      ),
    );
  }
}

// Word Card Data Modal
class WordCard {
  final String word;
  final String description;
  WordCard({this.word, this.description});
}

// Word Card Repository
class WordCardRepository {
  List<WordCard> cards;
  WordCardRepository({this.cards});
}

// Wowrd Card Cubit and Bloc
abstract class WordCardsEvent {}

abstract class WordCardsState {}

class LoadWordCardsEvent extends WordCardsEvent {}

class LoadingWordCardsState extends WordCardsState {}

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

// Synonym Data Modal
class Synonym {
  final String word;
  final List<String> synonym;
  Synonym({this.word, this.synonym});
}

// Synonym Repository


// Synonym Cubit

// Synonym Detail View
class DetailView extends StatelessWidget {
  static const valueKey = ValueKey("DetailView");
  final List<String> synonyms = [
    "detect",
    "find",
    "notice",
    "observe",
    "describe",
    "distinguish",
    "identify",
    "key",
    "key out",
    "name",
    "find out",
    "get a line",
    "get wind",
    "get word",
    "hear",
    "learn",
    "pick up",
    "see",
    "break",
    "bring out",
    "disclose",
    "divulge",
    "expose",
    "give away",
    "let on",
    "let out",
    "reveal",
    "uncover",
    "unwrap",
    "attain",
    "chance on",
    "chance upon",
    "come across",
    "come upon",
    "fall upon",
    "happen upon",
    "light upon",
    "strike"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Discover"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Card(
                  child: ListTile(
                    title: Text("Definition: what you have typed"),
                  ),
                )),
            Expanded(
              flex: 2,
              // child: Expanded(
              // color: Colors.grey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Synonym",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: synonyms.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(synonyms[index]),
                            ),
                          );
                        }),
                  )
                ],
              ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
