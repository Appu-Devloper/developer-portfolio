import 'package:flutter/material.dart';

class SectionItem {
  final String title;
  final String description;
  final String period;

  SectionItem({
    required this.title,
    required this.description,
    required this.period,
  });
}

class ExperienceProvider with ChangeNotifier {
  List<SectionItem> _experienceList = [
    SectionItem(
      title: "Software Development Engineer",
      description: "Developed scalable software solutions to meet business needs, ensuring high performance and maintainability.\n"
          "Integrated hardware components for seamless data processing and IoT connectivity.\n"
          "Implemented full-stack IoT solutions with backend scalability and responsive frontends.\n",
      period: "Jan 2025 – Present",
    ),
    SectionItem(
      title: "Application Engineer",
      description: "Built high-performance cross-platform applications with Flutter, surpassing 5,000+ downloads.\n"
          "Optimized SQL queries and backend processes, reducing response times significantly.\n"
          "Designed scalable database architectures to handle concurrent users and heavy loads.\n",
      period: "Jan 2023 – Jan 2025",
    ),
  ];

  List<SectionItem> get experienceList => _experienceList;

  void addExperience(SectionItem newExperience) {
    _experienceList.add(newExperience);
    notifyListeners();
  }
}
