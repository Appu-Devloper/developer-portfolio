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
  title: "Windows-Based Calibration Metrology Software",
  features: [
 "Tkinter-based GUI for calibrating DMMs and oscilloscopes using Fluke calibrators.",
    "Integrates PyVISA and serial comms, with live JSON output for Flutter integration.",
    "Supports GOST mode, auto Excel reports, and real-time measurement validation.",
    "Fully CLI-controllable via stdin/stdout for headless or app-driven operation.",
  ],
  buttons: {
    "GitHub Repository": "https://github.com/Appu-Devloper/website_template.git",
  },
  isPrivate: true,
),

    ProjectItem(
      title: "Excel Comparison & Validation",
      features: [
        "Enterprise Solution for customer-specific validation.",
        "Built for comparing & validating Excel data efficiently.",
        "Integrated Python API for automated backend processing.",
        "Reduces manual efforts & improves data accuracy.",
      ],
      buttons: {},
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
      buttons: {},
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
   
    ProjectItem(
      title: "Attendance & Leave Management App",
      features: [
        "Simplifies workforce attendance using Google App Scripts as backend.",
        "Tracks check-ins, leave requests, approvals, and reports.",
        "Built with Flutter and responsive UI for HR teams.",
        "Ideal for small/medium businesses and remote teams.",
      ],
      buttons: {
        "GitHub Repository": "https://github.com/Appu-Devloper/attendance_app_google_script.git",
      },
      isPrivate: true,
    ),
    ProjectItem(
      title: "UPSC Aspirant – AI Quiz App",
      features: [
        "AI-powered quiz app for UPSC preparation using category-wise question generation.",
        "Dynamically generated MCQs to avoid repetition.",
        "Includes answer animation, result summary, multilingual support.",
        "Offline cache and language switching for a smooth learning experience.",
      ],
      buttons: {
        "GitHub Repository": "https://github.com/Appu-Devloper/UPSC_ASPIRANT.git",
      },
      isPrivate: false,
    ),
    ProjectItem(
      title: "More Open Source Projects on GitHub",
      features: [
        "Includes Flutter apps with BLoC implementation, API integration, MQTT & Sqflite support.",
        "Beautifully crafted UI templates for portfolios, landing pages, and more.",
        "Explores advanced concepts like real-time data sync, animated charts, and custom UI components.",
        "Always adding new experiments and tools to help devs build faster.",
      ],
      buttons: {
        "Visit GitHub": "https://github.com/Appu-Devloper",
      },
      isPrivate: false,
    ),
  ];

  notifyListeners();
}

}
