import 'package:flutter/material.dart';

class ProjectItem {
  final String title;
  final List<String> features;
  final Map<String,String> buttons;
  final bool isPrivate;

  ProjectItem({
    required this.title,
    required this.features,
    required this.buttons,
    required this.isPrivate,
  });
}

class ProjectsProvider extends ChangeNotifier {
  List<ProjectItem> _projects = [];

  List<ProjectItem> get projects => _projects;

 
    void fetchProjects() {
  _projects = [
    ProjectItem(
      title: "Cross-Platform App (Android & iOS)",
      features: [
        "Developed Cross-Platform App for multimedia streaming.",
        "Integrated FCM for real-time push notifications.",
        "Connected app to backend servers using REST APIs.",
        "Implemented deep linking for better user navigation.",
      ],
      buttons: {
        "Android": "https://play.google.com/store/apps/details?id=com.vn.vishwanandini",
        "IOS": "https://apps.apple.com/us/app/vishwanandini/id6499511065",
      },
      isPrivate: false,
    ),
    ProjectItem(
      title: "Excel Comparison & Validation",
      features: [
        "Enterprise Solution for customer-specific validation.",
        "Built for comparing & validating Excel data efficiently.",
        "Integrated Python API for automated backend processing.",
        "Reduces manual efforts & improves data accuracy.",
      ],
      buttons: {}, // No buttons for private projects
      isPrivate: true,
    ),
    ProjectItem(
      title: "IoT Dashboard for Data Management",
      features: [
        "Custom-built IoT dashboard for real-time data tracking.",
        "Deployed at customer site for secured data handling.",
        "Integrated MQTT, Apache, & Nginx for seamless connectivity.",
        "Helps businesses visualize & manage critical insights.",
      ],
      buttons: {}, // No buttons for private projects
      isPrivate: true,
    ),
    ProjectItem(
      title: "The Ayurveda Chatbot",
      features: [
        "Flutter-based mobile application providing Ayurvedic health guidance.",
        "AI-powered responses for herbal remedies, doshas, diet, yoga, and traditional medicine.",
        "Uses Google Gemini AI to generate personalized Ayurvedic solutions.",
        "User-friendly interface with intuitive navigation for better experience.",
      ],
      buttons: {
        "GitHub Repository": "https://github.com/Appu-Devloper/Ayurvedic_chatBot.git",
      },
      isPrivate: false,
    ),
  ];
  notifyListeners();



  }
}
