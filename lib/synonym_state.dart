abstract class SynonymState {}

class LoadingSynonym extends SynonymState {}

class LoadedSynonymSuccess extends SynonymState {
  final List<String> synonym;
  LoadedSynonymSuccess({this.synonym});
}
