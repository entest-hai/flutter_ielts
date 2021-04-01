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
