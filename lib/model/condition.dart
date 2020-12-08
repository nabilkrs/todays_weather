class Condition {
  String text;
  Condition({this.text});
  factory Condition.fromJSON(Map<String, dynamic> post) {
    return Condition(text: post['current']['condition']['text'],);
  }
}
