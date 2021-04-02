import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// wordcard event state and bloc
import 'wordcard.dart';
import 'wordcard_state.dart';
import 'wordcard_bloc.dart';
import 'wordcard_event.dart';
// synonym state and cubit
import 'synonym_cubit.dart';
import 'synonym_state.dart';

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => WordCardsBloc()..add(LoadWordCardsEvent())),
          BlocProvider(create: (context) => SynonymCubit())
        ],
        child: VocalbularyNavigator(),
      ),
    );
  }
}

class VocalbularyNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
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
            if (_selectedWord != null)
              MaterialPage(
                  key: DetailView.valueKey,
                  child: DetailView(
                    selectedWord: _selectedWord,
                  ))
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
                      BlocProvider.of<SynonymCubit>(context)
                          .fetchSynonym(state.cards[index].word);
                      didSelecteWord("Test");
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

// Synonym Detail View
class DetailView extends StatelessWidget {
  final String selectedWord;
  static const valueKey = ValueKey("DetailView");
  DetailView({Key key, this.selectedWord}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("$selectedWord"),
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
                    child: BlocBuilder<SynonymCubit, SynonymState>(
                      builder: (context, state) {
                        if (state is LoadingSynonym) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LoadedSynonymSuccess) {
                          return ListView.builder(
                              itemCount: state.synonym.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(state.synonym[index]),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: Text("Exception"),
                          );
                        }
                      },
                    ),
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
