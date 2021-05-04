class Answers {
  final int id;
  final String text;

  Answers({this.id, this.text});
}

class Questions {
  final int id;
  final String text;
  final String mark;

  final List<Answers> answers;

  Questions({this.id, this.text, this.answers, this.mark});
}

class Quizes {
  final int id;
  final String name;
  final int totlaMark;

  final List<Questions> questions;

  Quizes({this.id, this.name, this.questions, this.totlaMark});
}

class Sections {
  final int id;
  final String name;

  final List<Quizes> quizes;

  Sections({this.id, this.name, this.quizes});
}
