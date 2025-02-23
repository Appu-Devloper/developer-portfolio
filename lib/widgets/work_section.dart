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
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 480, name: MOBILE),
        const Breakpoint(start: 481, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1200, name: DESKTOP),
        const Breakpoint(start: 1201, end: 2460, name: '4K'),
      ],
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          alignment: Alignment.center,
          child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);
          return Center(
            child: Wrap(alignment: WrapAlignment.center,crossAxisAlignment: WrapCrossAlignment.center,
              spacing: isMobile ? 0 : 20.0,
              runSpacing: 20.0,
              children: projects.map(
                (item) =>
                   Container(
                   
                    width: isMobile ? double.infinity : (constraints.maxWidth / 2) - 20.0,
                    child: _buildProjectDetails(item))).toList(),
                ),
          );},
            ),
          ),
      ),
      );
    
  }

  Widget _buildProjectDetails(ProjectItem project) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title.toUpperCase(),
              style: GoogleFonts.oswald(
                color: primaryColor,
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
                    .map((buttonText) => _buildButton(
                          text: buttonText,
                          color: primaryColor,
                          textColor: Colors.white,
                        ))
                    .toList(),
              )
            else
              Container(
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
              ),
          ],
        
      
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: primaryColor, size: 16.0),
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

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
       border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: color,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ProjectItem {
  final String title;
  final List<String> features, buttons;
  final bool isPrivate;

  ProjectItem({required this.title, required this.features, required this.buttons, required this.isPrivate});
}
