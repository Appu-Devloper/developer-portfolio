import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8F2FF), Color(0xFFEFF6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Social Links
          _buildSocialLinks(),

          const SizedBox(height: 20.0),

          // Built with Love & Copyright
          Text(
            "Built with Flutter ❤️",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8.0),

          Text(
            "© 2025 Appu M. All rights reserved.",
            style: GoogleFonts.montserrat(
              color: Colors.black54,
              fontSize: 15.0,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  /// **Social Links Section**
  Widget _buildSocialLinks() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 25.0,
      runSpacing: 12.0,
      children: [
        _socialButton(
          FontAwesomeIcons.github,
          "GitHub",
          "https://github.com/Appu-Devloper",
        ),
        _socialButton(
          FontAwesomeIcons.linkedin,
          "LinkedIn",
          "https://www.linkedin.com/in/appu-m-19894a258/",
        ),
        _socialButton(
          FontAwesomeIcons.envelope,
          "Email",
          "mailto:appua0126@gmail.com",
        ),
        _socialButton(FontAwesomeIcons.phone, "Phone", "tel:+918861357375"),
      ],
    );
  }

  /// **Clean & Minimalist Social Button**
  Widget _socialButton(IconData icon, String tooltip, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(50),
      splashColor: Colors.purpleAccent.withValues(alpha: 0.2),
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: FaIcon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }

  /// **Function to Open URLs**
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }
}
