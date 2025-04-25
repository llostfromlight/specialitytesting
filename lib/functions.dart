import 'package:flutter/material.dart';
import 'package:specialitytesting/objects/question.dart';

// 1 [10 11] [100 101 110 111] [1000 1001 1010 1011 1100 1101 1110 1111] [10001 ]
final List<String> questionList = [
  "Do you enjoy translating abstract ideas into visual outputs?", //0
  "Are you energized by identifying hidden weaknesses in systems?", //1
  "Do you love organizing chaos?",//00
  "Are you interested in how people interact with technology?", //01
  "Do you prefer building tools over using existing ones?", //10
  "Do you thrive in high-pressure scenarios?", //11
];

String tobinary(int n) {
  if (n <= 1) return n.toString();
  int a = n ~/ 2;
  return tobinary(a) + (n - 2 * a).toString();
}

Map<String, Question> initializingMap(double height) {
  Map<String, Question> map = {};
  String temp;
  int index = 0;
  for (var bits = 1; bits <= 2; bits++) {
    for (var n = 0; tobinary(n).length <= bits; n++) {
      temp = tobinary(n);
      //add zeros if binary form length below i
      while (temp.length < bits) {
        temp = "0$temp";
      }
      print(temp);
      map.addAll({
        temp: Question(
            txt: questionList[index],
            image: intilizeImage(path: "images/$temp.jpg", height: height),
            code: temp)
      });
      index++;
    }
  }
  return map;
}

Image intilizeImage({required String path, double? height}) {
  return Image.asset(
    height: height,
    fit: BoxFit.fitWidth,
    path,
  );
}
