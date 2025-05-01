import 'package:flutter/material.dart';
import 'package:specialitytesting/functions.dart';

class Question {
  String code = "xxxxxx";
  int? index;
  String txt = "error";
  Image image;
  Question(
      {required this.txt, required this.image, required this.code, this.index});

  Question.newlist({required this.txt, required this.image}) {
    index = 0;
    code = "xxxxxx";
  }

  Question update(double height, bool yn) {
    if (index == null) throw (ArgumentError.notNull());
    return Question(
        code: updateCode(index: index!, ch: yn),
        txt: questionList[index!],
        image: initializeImage(name: "$index", height: height),
        index: index);
  }

  void updateIndex(int x, double height) {
    if (x > questionList.length || x < 0) throw (ArgumentError());
    index = x;
    image = initializeImage(name: "$index", height: height);
    txt = questionList[index!];
  }

  String updateCode({required int index, required bool ch}) {
    //since after you press on y or n index is already updated to next value and we must modefy the last digit not the current
    //we go for index -1 and if the index is null it will throw anyways
    return code.replaceRange(index - 1, index, ch ? "1" : "0");
  }

  String finish(bool yn) {
    code = updateCode(index: index! + 1, ch: yn);
    return code;
  }

  List<double> answertoList() {
    List<double> l = [];
    double n = double.parse(code);
    for (var i = 0; i < code.length; i++) {
      l.add(n % 10);
      n = (n ~/ 10).toDouble();
    }
    return l.reversed.toList();
  }
}
