class QuestionModel {
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  int selected;
  QuestionModel(
      {this.selected,
      this.question,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD});
}

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
