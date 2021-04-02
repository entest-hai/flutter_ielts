class Question {
  final String question;
  final List<String> options;
  final List<bool> selections;
  bool answered;
  Question({
    String question,
    List<String> options,
    List<bool> selections,
    answered,
  })  : this.question = question,
        this.options = options,
        this.selections =
            selections ?? List<bool>.generate(options.length, (index) => false),
        this.answered = answered ?? false;
}
