class Current {
  double tempc, tempf;
  Current({this.tempc, this.tempf});
  factory Current.fromJSON(Map<String, dynamic> post) {
    return Current(
      tempc: post['current']['temp_c'],
      tempf: post['current']['temp_f'],
    );
  }
}
