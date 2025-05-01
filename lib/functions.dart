import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specialitytesting/specialitytesting.dart';

final List<String> questionList = [
  "Each workday, do you spend at least 5 minutes organizing your desk and tools before starting any task?\n",
  "When a problem appears, do you routinely spend 15 minutes tracing back to its root cause before applying any quick fix?\n",
  "If a weekly task takes more than 30 minutes, do you look for or build a shortcut to automate it?\n",
  "Before starting a new personal or work project, do you sketch at least three rough ideas for 10+ minutes?\n",
  "When you notice a small warning sign (missed deadline, minor bug), do you spend time that day preventing it from growing?\n",
  "When you see a jumble of facts, do you enjoy hunting for patterns you can predict from?"
];
// final List<String> questionList = [
//   "When a problem appears, do you routinely spend 15 minutes tracing back to its root cause before applying any quick fix?\n(Analytical/Root-Cause Focus—single, timed action)",
//   "If a weekly task takes more than 30 minutes, do you look for or build a shortcut to automate it?\n(Innovation & Efficiency—weekly frequency + action)",
//   "Before starting a new personal or work project, do you sketch at least three rough ideas for 10+ minutes?\n(Planning & Visualization—single, timed planning session)",
//   "When you notice a small warning sign (missed deadline, minor bug), do you spend time that day preventing it from growing?\n(Proactive Risk-Management—same-day response habit)",
//   "When you see a jumble of facts, do you enjoy hunting for patterns you can predict from?"
// ];


Image initializeImage({required String name, double? height}) {
  return Image.asset(
    height: height,
    fit: BoxFit.fitWidth,
    "images/$name.jpg",
  );
}

int finalResult(Answer result) {
  String s = result.result;
  print(s);
  // List of patterns (6-bit, use 'x' for wildcard)
  final patterns = [
    "00xx00", // 0: Front-end Developer
    "00xx01", // 1: Software Engineer
    "01xx10", // 2: DevOps Engineer
    "10xx11", // 3: Security Specialist
    "11xx00", // 4: Data Analyst
    "10xx00", // 5: Embedded Systems Engineer (was 9)
    "xx010x", // 6: UX Designer (was 5)
    "xx101x", // 7: Network Administrator (was 6)
    "xx111x", // 8: QA Tester (was 7)
    "xxxxx1", // 9: AI/ML Engineer (was 8)
  ];

  for (int i = 0; i < patterns.length; i++) {
    if (i == 9) {
      continue; //the posibility for xxxxx1 is high asf to get i will test this one alone after other cases
    }
    if (result.equal(patterns[i])) {
      return i;
    }
  }

  // Fallback: Only codes ending in …01 → QA Tester
  // Catches surface mistakes immediately.
  // Forbes (speed-and-innovation article)
  if (s.endsWith("01")) {
    return 8; // QA Tester (now at index 8)
  }

  // Fallback: Only codes ending in …10 → Network Administrator
  // Roots out hidden issues before they escalate.
  // Indeed: Network Administrator Skills
  if (s.endsWith("10")) {
    return 7; // Network Administrator (now at index 7)
  }

  // Fallback: Only codes ending in …11 → AI/ML Engineer
  // Driven to teach computers to learn from patterns.
  // IBM: What Is AI?
  if (s.endsWith("1")) {
    return 9; // AI/ML Engineer (now at index 9)
  }

  // Not found
  return -1;
}


/*
 * Only codes ending in …01 → QA Tester
 * Catches surface mistakes immediately.
 * Forbes (speed-and-innovation article)
 * Forbes
 *
 * Only codes ending in …10 → Network Administrator
 * Roots out hidden issues before they escalate.
 * Indeed: Network Administrator Skills
 * Job Search | Indeed
 *
 * Only codes ending in …11 → AI/ML Engineer
 * Driven to teach computers to learn from patterns.
 * IBM: What Is AI?
 * IBM - United States
 *
 * The other five branches share the remaining patterns, each triggered by distinct mid-bit combinations—keeping every specialty in clear view.
 *
 * Mapping Your 6-Bit Code to IT Branches
 * 6-Bit Code Pattern    IT Branch               Key Trait Alignment                                         Source
 * 0 0 x x 0 0           Front-end Developer     You organize and craft clean interfaces—building polished  CareerFoundry: Front-end Skills
 *                                               user experiences.                                           CareerFoundry
 * 0 0 x x 0 1           Software Engineer       You probe deeper causes and build robust, maintainable     Indeed: Successful Engineers
 *                                               solutions.                                                  Job Search | Indeed
 * 0 1 x x 1 0           DevOps Engineer         You automate repetitive chores and streamline operations   Forbes: Speed & Innovation
 *                                               for reliability and speed.                                 Forbes
 * 1 0 x x 1 1           Security Specialist     You proactively neutralize risks before they grow—keeping  CIO: Critical Security Skills
 *                                               systems safe.                                               CIO
 * 1 1 x x 0 0           Data Analyst            You dig into data, spotting patterns and translating them  CareerFoundry: Data Analytics
 *                                               into insights.                                              CareerFoundry
 * x x 0 1 0 x           UX Designer             You sketch and iterate ideas visually—designing for user   CareerFoundry: UX Skills
 *                                               empathy and clarity.                                        CareerFoundry
 * x x 1 0 1 x           Network Administrator   You troubleshoot root causes and ensure smooth, reliable   Indeed: Network Skills
 *                                               connections in complex systems.                             Job Search | Indeed
 * x x 1 1 1 x           QA Tester               You spot surface errors on the spot—guaranteeing high      Forbes: Speed & Innovation
 *                                               quality before release.                                     Forbes
 * x x x x x 1           AI/ML Engineer          You’re most excited by teaching machines to learn—focused  IBM: What Is AI?
 *                                               on model building and data science.                        IBM - United States
 */