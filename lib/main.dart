import 'dart:io';
import 'package:flutter/material.dart';
import 'package:specialitytesting/backend/data.dart';
import 'package:specialitytesting/functions.dart';
import 'package:specialitytesting/objects/answer.dart';
import 'package:specialitytesting/objects/question.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
// Function to close the app (used for "No" answers and at the end)

var theme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: const Color(0xFF28A745),
  brightness: Brightness.light,
);
// Entry point of the app, runs the MaterialApp with root widget
void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Data(),
    child: MaterialApp(
      home: root(),
      debugShowCheckedModeBanner: false,
      theme: theme,
    ),
  ));
}

// Root widget to get screen height and pass it to MainApp
class root extends StatelessWidget {
  const root({super.key});

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Data>(context).imageHeight == null) {
      Provider.of<Data>(context)
          .initializeState(MediaQuery.of(context).size.height);
    }
    return MainApp();
  }
}

// Main stateful widget for the quiz logic and UI
class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

// State class for MainApp, handles question flow and UI updates
class _MainAppState extends State<MainApp> {
  final double rationHeight = 0.65;

  void resultpage(String resultText) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Finalanswer(result: resultText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Data>();

    provider.imageHeight = MediaQuery.of(context).size.height * rationHeight;
    void next(bool t) {
      provider.next(t);
      if (provider.finished) resultpage(provider.answer.result);
    }

    return Scaffold(
      appBar: AppBar(
        title: Selector<Data, String>(
          builder: (context, value, child) => Text(value),
          selector: (p0, p1) => p1.barTitel,
        ),
      ),
      drawer: Drawer(
        child: Selector<Data, List<ListTile>>(
            builder: (context, value, child) => ListView(
                  children: value,
                ),
            selector: (p0, p1) => p1.drawerItems),
      ),
      //	#F5F7FA
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
              child: Selector<Data, Question>(
                builder: (context, value, child) => value.image,
                selector: (p0, p1) => p1.cquestion,
              ),
            ),
            const SizedBox(height: 20),
            // Question text
            Selector<Data, double>(
              selector: (p0, p1) => p1.imageHeight!,
              builder: (context, value, child) => Selector<Data, Question>(
                builder: (context, value, child) =>
                    Text(textAlign: TextAlign.center, value.txt),
                selector: (p0, p1) => p1.cquestion,
              ),
            ),
            const SizedBox(height: 20),
            // Yes/No buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    style: FilledButton.styleFrom(
                        //#dc3545
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: Colors.white),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () {
                      closeApp();
                    },
                    child: const Text("Good luck"),
                  ),
                  const SizedBox(width: 20),
                  FilledButton(
                      child: const Text("Check result"),
                      onPressed: () {
                        statics(context);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> statics(BuildContext context) {
    return showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          final provider = Provider.of<Data>(context);
          final defList = provider.defList
              .map(
                (element) => "  $element  ",
              )
              .toList();
          final answers = provider.answers;
          final demantions = MediaQuery.of(context).size;
          final ration = 0.45;
          const double defaultAngle = 0;
          return AlertDialog(
            title: Text("Result : "),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Statics : ",
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  height: demantions.height * ration,
                  width: demantions.width * ration,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16), // Smooth rounded corners
                    border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1), // Optional subtle border
                  ),
                  child: RadarChart(
                    RadarChartData(
                      isMinValueAtCenter: true,
                      dataSets: [
                        RadarDataSet(
                          entryRadius: 4,
                          dataEntries: [
                            for (int i = 0; i < answers.length; i++)
                              RadarEntry(value: answers[i]),
                          ],
                        )
                      ],
                      radarShape: RadarShape.polygon,
                      tickCount: 1,
                      getTitle: (index, angle) {
                        switch (index) {
                          case 0:
                            return RadarChartTitle(
                              text: defList[0],
                              angle: defaultAngle,
                            );
                          case 1:
                            return RadarChartTitle(
                              text: defList[1],
                              angle: defaultAngle,
                            );
                          case 2:
                            return RadarChartTitle(
                              text: defList[2],
                              angle: defaultAngle,
                            );
                          case 3:
                            return RadarChartTitle(
                              text: defList[3],
                              angle: defaultAngle,
                            );
                          case 4:
                            return RadarChartTitle(
                              text: defList[4],
                              angle: defaultAngle,
                            );
                          case 5:
                            return RadarChartTitle(
                              text: defList[5],
                              angle: defaultAngle,
                            );
                          default:
                            return const RadarChartTitle(text: '');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
