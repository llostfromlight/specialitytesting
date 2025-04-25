import 'package:flutter/material.dart';
class Question {
  final String code;
  final String txt;
  final String? result;
  final Image image;

  Question({
    required this.code,
    required this.txt,
    required this.image,
    this.result,
  });

  String get yesCode => '${code}1';
  String get noCode => '${code}0';
}

// Decision Tree Initialization
final List<String> questionList = [
  "Do you prefer structured problem-solving over open-ended exploration?",
  "Are you energized by identifying hidden weaknesses in systems?",
  "Do you enjoy translating abstract ideas into visual outputs?",
  "Do you thrive in high-pressure scenarios?",
  "Do you prefer building tools over using existing ones?",
  "Are you interested in how people interact with technology?",
  "Do you love organizing chaos?",
];

Map<String, Question> initializeDecisionTree(double height) {
  final map = <String, Question>{};
  final resultMapping = {
    '111': 'Cybersecurity 🛡️',
    '110': 'Quality Assurance 🔍',
    '101': 'Software Engineering 💻',
    '100': 'DevOps/Cloud ☁️',
    '011': 'UX/UI Design 🎨',
    '010': 'Technical Writing 📝',
    '0001': 'Data Analysis 📊',
    '0000': 'IT Project Management 📅',
  };

  // Add regular questions
  for (int i = 0; i < questionList.length; i++) {
    final code = i.toRadixString(2).padLeft(3, '0').substring(1);
    map[code] = Question(
      code: code,
      txt: questionList[i],
      image: _loadImage('images/$code.jpg', height),
    );
  }

  // Add result nodes
  resultMapping.forEach((code, result) {
    map[code] = Question(
      code: code,
      txt: 'Career Path Determined!',
      image: _loadImage('images/results/$code.jpg', height),
      result: result,
    );
  });

  return map;
}

Image _loadImage(String path, double height) => Image.asset(
  path,
  height: height,
  fit: BoxFit.cover,
  errorBuilder: (_, __, ___) => Icon(Icons.question_mark, size: height),
);

// Main Widget
class CareerPathFinder extends StatefulWidget {
  final double imageSize;

  const CareerPathFinder({super.key, this.imageSize = 300});

  @override
  State<CareerPathFinder> createState() => _CareerPathFinderState();
}

class _CareerPathFinderState extends State<CareerPathFinder> {
  late Map<String, Question> decisionTree;
  late Question currentQuestion;
  String currentPath = '';

  @override
  void initState() {
    super.initState();
    decisionTree = initializeDecisionTree(widget.imageSize);
    currentQuestion = Question(
      code: '',
      txt: "Ready to discover your ideal IT career path?",
      image: _loadImage('images/welcome.jpg', widget.imageSize),
    );
  }

  void _handleAnswer(bool isYes) {
    setState(() {
      final newCode = isYes ? currentQuestion.yesCode : currentQuestion.noCode;
      
      if (decisionTree.containsKey(newCode)) {
        currentPath = newCode;
        currentQuestion = decisionTree[newCode]!;
      } else {
        currentQuestion = Question(
          code: newCode,
          txt: "Path not found - try different answers!",
          image: _loadImage('images/error.jpg', widget.imageSize),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: currentQuestion.image,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currentQuestion.txt,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (currentQuestion.result != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Result: ${currentQuestion.result!}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () => _handleAnswer(false),
                  child: const Text('No'),
                ),
                const SizedBox(width: 20),
                FilledButton(
                  onPressed: () => _handleAnswer(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}