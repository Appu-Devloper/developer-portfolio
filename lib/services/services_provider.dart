import 'package:flutter/material.dart';

class Service {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> features;

  Service({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.features,
  });
}

class ServicesProvider extends ChangeNotifier {
  List<Service> _services = [];

  List<Service> get services => _services;

  void fetchServices() {
    _services = [
      Service(
        title: "Cross-Platform App Development",
        description:
            "Building high-quality mobile applications using Flutter and Dart with modern UI/UX principles and optimal performance.",
        icon: Icons.phone_android,
        color: Colors.tealAccent,
        features: ["Flutter", "Dart", "MVVM Architecture", "State Management"],
      ),
      Service(
        title: "Backend & API Development",
        description:
            "Expert in designing and integrating scalable RESTful APIs, optimizing SQL databases, and handling real-time IoT data processing.",
        icon: Icons.cloud,
        color: Colors.amberAccent,
        features: ["SQL", "API Design", "Postman", "Firebase Cloud Messaging"],
      ),
      Service(
        title: "IoT & Embedded Systems",
        description:
            "Collaborating with hardware teams for seamless device integration, enabling real-time data visualization and efficient processing.",
        icon: Icons.settings_remote,
        color: Colors.cyanAccent,
        features: ["MQTT", "BLE", "WiFi", "IoT Dashboards"],
      ),
    ];
    notifyListeners();
  }
}
