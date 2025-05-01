class Answer {
  String result = "empty";
  Answer(this.result);
  bool equal(String s) {
    if (result.length == s.length) {
      for (var i = 0; i < s.length; i++) {
        if (s[i] == "x") continue; // wildcard
        if (result[i] != s[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}