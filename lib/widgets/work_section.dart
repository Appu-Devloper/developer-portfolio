import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../utils/constants.dart';

class IosAppAd extends StatefulWidget {
  @override
  _IosAppAdState createState() => _IosAppAdState();
}

class _IosAppAdState extends State<IosAppAd> {
  final List<ProjectItem> projects = [
    ProjectItem(
      title: "Cross-Platform App (Android & iOS)",
      features: [
        "Developed Cross-Platform App for multimedia streaming.",
        "Integrated FCM for real-time push notifications.",
        "Connected app to backend servers using REST APIs.",
        "Implemented deep linking for better user navigation.",
      ],
      buttons: ["Open Android App", "Open iOS App"],
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
      buttons: [],
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
      buttons: [],
      isPrivate: true,
    ),
    ProjectItem(
      title: "The Ayurveda Chatbot",
      features: [
        "Flutter-based mobile application providing Ayurvedic health guidance.",
        "AI-powered responses for herbal remedies, doshas, diet, yoga, and traditional medicine.",
        "Uses Google Gemini AI to generate personalized Ayurvedic solutions.",
        "User-friendly interface with intuitive navigation for better experience."
      ],
      buttons: ["GitHub Repository"],
      isPrivate: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);
            return Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: isMobile ? 0 : 20.0,
              runSpacing: 20.0,
              children: projects
                  .map((item) => _buildProjectBox(item, constraints, isMobile))
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  /// 🟦 **Creates a Boxed Section for Each Card**
  Widget _buildProjectBox(ProjectItem project, BoxConstraints constraints, bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : (constraints.maxWidth / 2) - 20.0,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // **Background Pattern inside Box**
          Positioned.fill(child: CustomPaint(painter: CardBackgroundPainter())),
          _buildProjectCard(project),
        ],
      ),
    );
  }

  /// 🟩 **Project Card with Glassmorphism & Light Colors**
  Widget _buildProjectCard(ProjectItem project) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.9), Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title.toUpperCase(),
            style: GoogleFonts.oswald(
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              fontSize: 22.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: project.features
                .map((feature) => _buildFeatureItem(feature))
                .toList(),
          ),
          const SizedBox(height: 20.0),
          if (!project.isPrivate)
            Wrap(
              spacing: 10.0,
              children: project.buttons
                  .map((buttonText) => _buildButton(text: buttonText))
                  .toList(),
            )
          else
            _buildPrivateTag(),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.blueAccent, size: 16.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required String text}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPrivateTag() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock, color: Colors.red, size: 18),
          SizedBox(width: 8),
          Text(
            "Enterprise Solution",
            style: GoogleFonts.poppins(
              color: Colors.red,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 🎨 **Light Pattern Inside Each Box**
class CardBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.blue.withOpacity(0.1);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 50, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.8), 70, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class ProjectItem {
  final String title;
  final List<String> features, buttons;
  final bool isPrivate;

  ProjectItem({required this.title, required this.features, required this.buttons, required this.isPrivate});
}
