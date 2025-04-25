import 'dart:io';
import 'package:flutter/material.dart';
import 'package:specialitytesting/functions.dart';
import 'package:specialitytesting/objects/question.dart';
import 'package:flutter/services.dart';

// Entry point of the app, runs the MaterialApp with root widget
void main() {
  runApp(const MaterialApp(home: root()));
}

// Root widget to get screen height and pass it to MainApp
class root extends StatelessWidget {
  const root({super.key});

  @override
  Widget build(BuildContext context) {
    double basich = MediaQuery.of(context).size.height;
    return MainApp(imageHeight: basich);
  }
}

// Function to close the app (used for "No" answers and at the end)
void closeApp() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  exit(0);
}

// Main stateful widget for the quiz logic and UI
class MainApp extends StatefulWidget {
  final double imageHeight;
  MainApp({super.key, required this.imageHeight});

  @override
  State<MainApp> createState() => _MainAppState();
}

// State class for MainApp, handles question flow and UI updates
class _MainAppState extends State<MainApp> {
  late Question cquestion; // Current question object
  late Map<String, Question> map; // Map of question code to Question
  final double rationHeight = 0.65; // Image height ratio
  int layer = 0; // Tracks current step in the quiz

  @override
  void initState() {
    super.initState();
    // Initialize the question map and set the first question
    map = initializingMap(widget.imageHeight);
    cquestion = Question(
        txt:
            "Hello dear,They told me you are here to check your natural talent in IT using our advanced expansive service is that true ? ",
        image: intilizeImage(
            path: "images/image.jpg",
            height: widget.imageHeight * rationHeight),
        code: "");
  }

  // Navigates to the result page with the final answer string
  void nextpage(t) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Finalanswer(
            result: switch ((t) ? cquestion.yes() : cquestion.no()) {
          "111" =>
            "Result: Cybersecurity 🛡️\n\nYou love defending systems and thrive in adversarial environments.",
          "110" =>
            "Result: Quality Assurance/Testing 🔍\n\nYou enjoy methodical validation and ensuring perfection.",
          "101" =>
            "Result: Software Engineering 💻\n\nYou prefer creating scalable solutions from scratch.",
          "100" =>
            "Result: DevOps/Cloud ☁️\n\nYou love bridging development and operations with automation.",
          "011" =>
            "Result: UX/UI Design 🎨\n\nYou prioritize user emotions and accessibility.",
          "010" =>
            "Result: Technical Writing 📝\n\nYou excel at simplifying complexity for others.",
          "001" =>
            "Result: Data Analysis 📊\n\nYou enjoy finding patterns in information.",
          "000" =>
            "Result: IT Project Management 📅\n\nYou’re a natural coordinator who loves timelines and teams.",
          _ => "Undefined path",
        }),
      ),
    );
  }

  // Handles advancing to the next question or result
  void next(bool t) {
    layer++;
    if (layer == 5) {
      nextpage(t);
    } else {
      if (layer > 2) {
        update(t);
      } else {
        intrudoctionupdate(t);
      }
    }
  }

  // Updates the question for the introduction steps (first two questions)
  void intrudoctionupdate(bool b) {
    if (!b) {
      closeApp();
    }
    setState(() {
      switch (layer) {
        case 1:
          cquestion = Question(
              txt:
                  "We have free plan for the special client like you would like to try it ?",
              image: intilizeImage(
                  path: "images/special.jpg",
                  height: widget.imageHeight * rationHeight),
              code: "");
          break;
        case 2:
          cquestion = Question(
              txt:
                  "Do you prefer structured problem-solving over open-ended exploration?",
              image: intilizeImage(
                  path: "images/.jpg",
                  height: widget.imageHeight * rationHeight),
              code: "");
          break;
      }
    });
  }

  // Updates the current question based on user answer (after intro)
  void update(bool t) {
    setState(() {
      if (t) {
        cquestion = map[cquestion.yes()]!;
      } else {
        cquestion = map[cquestion.no()]!;
      }
    });
  }

  // Builds the main quiz UI
  @override
  Widget build(BuildContext context) {
    double imageheight = MediaQuery.of(context).size.height * rationHeight;
    // Dynamically update the image based on the current layer/question
    setState(() {
      switch (layer) {
        case 0:
          cquestion.image =
              intilizeImage(path: "images/start.jpg", height: imageheight);
          break;
        case 1:
          cquestion.image =
              intilizeImage(path: "images/special.jpg", height: imageheight);
          break;

        case 2:
          cquestion.image =
              intilizeImage(path: "images/.jpg", height: imageheight);
          break;

        default:
          cquestion.image = intilizeImage(
              path: "images/${cquestion.code}.jpg", height: imageheight);
      }
    });
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // Image container with border
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Builder(builder: (context) {
                  return cquestion.image;
                })),
            const SizedBox(height: 20),
            // Question text
            Builder(builder: (context) {
              return Text(textAlign: TextAlign.center, cquestion.txt);
            }),
            const SizedBox(height: 20),
            // Yes/No buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () {
                      next(false);
                    },
                    child: Text("No")),
                const SizedBox(width: 20),
                FilledButton(
                    onPressed: () {
                      next(true);
                    },
                    child: Text("Yes")),
              ],
            )
          ],
        ),
      )),
    );
  }
}

// Final answer/result page shown at the end
class Finalanswer extends StatelessWidget {
  final String result;
  const Finalanswer({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result image
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.asset(
                  'images/image.jpg',
                  height: MediaQuery.of(context).size.height * 0.65,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 20),
              // Result text
              Text(
                result,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Close app button
              FilledButton(
                onPressed: () {
                  closeApp();
                },
                child: const Text("Good luck"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
