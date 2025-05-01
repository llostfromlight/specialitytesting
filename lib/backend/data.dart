import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:specialitytesting/specialitytesting.dart';

void closeApp() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  exit(0);
}

class Data extends ChangeNotifier {
  final theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF28A745),
  );
  final String initiaCode = "xxxxxx";
  bool finished = false;
  late List<ListTile> drawerItems;
  final double rationHeight = 0.65; // Image height ratio
  int layer = 0;
  final nIntroductionPages = 1;
  late Answer answer;
  double? imageHeight;
  late Question cquestion;
  List<double> answers = [];

  void initializeState(double height) {
    imageHeight = height * rationHeight;
    drawerItems = initializeDrawerItems();
    cquestion = Question(
      code: initiaCode,
      txt:
          "Hello dear,They told me you are here to check your natural talent in IT using our advanced expansive service is that true ? ",
      image: initializeImage(name: "start", height: imageHeight!),
    );
    updateBar();
  }

  void resultpage(bool t) {
    answer = Answer(cquestion.finish(t));
    // Use the answer object to get the result index
    int idx = finalResult(answer);
    // Map index to result string
    const results = [
      "Result: Front-end Developer 🎨\n\nYou organize and craft clean interfaces—building polished user experiences.",
      "Result: Software Engineer 💻\n\nYou probe deeper causes and build robust, maintainable solutions.",
      "Result: DevOps Engineer ☁️\n\nYou automate repetitive chores and streamline operations for reliability and speed.",
      "Result: Security Specialist 🛡️\n\nYou proactively neutralize risks before they grow—keeping systems safe.",
      "Result: Data Analyst 📊\n\nYou dig into data, spotting patterns and translating them into insights.",
      "Result: Embedded Systems Engineer ⚙️\n\nYou build and optimize hardware-software systems for real-world applications.",
      "Result: UX Designer 🖌️\n\nYou sketch and iterate ideas visually—designing for user empathy and clarity.",
      "Result: Network Administrator 🌐\n\nYou troubleshoot root causes and ensure smooth, reliable connections in complex systems.",
      "Result: QA Tester 🔍\n\nYou spot surface errors on the spot—guaranteeing high quality before release.",
      "Result: AI/ML Engineer 🤖\n\nYou’re most excited by teaching machines to learn—focused on model building and data science.",
    ];
    answer.result =
        (idx >= 0 && idx < results.length) ? results[idx] : "Undefined path";
    answers = cquestion.answertoList();
  }

  // Handles advancing to the next question or result
  void next(bool t) {
    layer++;
    if (cquestion.index == questionList.length - 1) {
      finished = true;
      resultpage(t);
    } else {
      if (layer > nIntroductionPages) {
        if (cquestion.index == null) {
          initializeQuestionToList();
        } else {
          update(t);
        }
      } else {
        intrudoctionupdate(t);
      }
    }
  }

  void initializeQuestionToList() {
    // setState(() {
    cquestion = Question.newlist(
        txt: questionList[0],
        image: initializeImage(name: "0", height: imageHeight));
    updateBar();
    notifyListeners();
    // });
  }

  // Updates the question for the introduction steps (first two questions)

  // Updates the current question based on user answer (after intro)
  void update(bool t) {
    final item = drawerItems[cquestion.index!];
    drawerItems[cquestion.index!] = ListTile(
      title: item.title,
      tileColor: (t) ? Colors.green.shade300 : Colors.red.shade300,
    );
    updateBar();
    cquestion.index = cquestion.index! + 1;

    if (t) {
      cquestion = cquestion.update(imageHeight!, true);
    } else {
      cquestion = cquestion.update(imageHeight!, false);
    }
    notifyListeners();
    // });
  }

  void intrudoctionupdate(bool b) {
    if (!b) {
      closeApp();
    }
    if (layer == 1) {
      cquestion = Question(
          txt:
              "We have free plan for the special client like you would like to try it ?",
          image: initializeImage(name: "special", height: imageHeight!),
          code: cquestion.code);
      notifyListeners();
    }
    // });
  }

  void updateImage() {
    // setState(() {
    switch (layer) {
      case 0:
        cquestion.image = initializeImage(name: "start", height: imageHeight);
        break;
      case 1:
        cquestion.image = initializeImage(name: "special", height: imageHeight);
        break;
      default:
        cquestion.image =
            initializeImage(name: "${cquestion.index}", height: imageHeight);
    }
    notifyListeners();
  }

  void updateImages() {}
  final defList = [
    "Organizational",
    "Analytical",
    "Innovation",
    "Planning",
    "Risk-Management",
    "Observation"
  ];
  ListTile addListTile(String s, int x) {
    return ListTile(
      title: Text(s),
      tileColor: Colors.grey,
    );
  }

  List<ListTile> initializeDrawerItems() {
    List<ListTile> l = [];
    for (var i = 0; i < defList.length; i++) {
      l.add(addListTile("${i + 1} : ${defList[i]}", i));
    }
    return l;
  }

  final barTitelList = ["Introduction", "Question"];
  late String barTitel;
  void updateBar() {
    barTitel = (cquestion.index == null)
        ? barTitelList[0]
        : "${barTitelList[1]} : ${cquestion.index! + 1}";
  }
}
