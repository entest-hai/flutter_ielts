class SynonymRepository {
  Future<List<String>> fetchSynonym() async {
    final List<String> synonym = [];
    synonym.add("OK");
    print("fetch synonym ");
    return synonym;
  }
}
