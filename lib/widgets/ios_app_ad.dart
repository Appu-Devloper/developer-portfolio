import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/responsive_widget.dart';

class IosAppAd extends StatelessWidget {
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ResponsiveWidget(
        desktop: _buildCarousel(context, kDesktopMaxWidth),
        tablet: _buildCarousel(context, kTabletMaxWidth),
        mobile: _buildCarousel(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, double width) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: Column(
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 350.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
              ),
              items: [
                _buildSlide(
                  "Cross-Platform App (Android & iOS)",
                  "assets/appdevlopment.png",
                  [
                    "Developed Cross-Platform App for multimedia streaming.",
                    "Integrated FCM for real-time push notifications.",
                    "Connected app to backend servers using REST APIs.",
                    "Implemented deep linking for better user navigation.",
                  ],
                  ["Open Android App", "Open iOS App"],
                ),
                _buildSlide(
                  "Excel Comparison & Validation",
                  "assets/excel.png",
                  [
                    "Enterprise Solution for customer-specific validation.",
                    "Built for comparing & validating Excel data efficiently.",
                    "Integrated Python API for automated backend processing.",
                    "Reduces manual efforts & improves data accuracy.",
                  ],
                  [],
                  isPrivate: true, // Mark as private
                ),
                _buildSlide(
                  "IoT Dashboard for Data Management",
                  "assets/iot.png",
                  [
                    "Custom-built IoT dashboard for real-time data tracking.",
                    "Deployed at customer site for secured data handling.",
                    "Integrated MQTT, Apache, & Nginx for seamless connectivity.",
                    "Helps businesses visualize & manage critical insights.",
                  ],
                  [],
                  isPrivate: true, // Mark as private
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavButton("◀", () => _carouselController.previousPage()),
                const SizedBox(width: 20.0),
                _buildNavButton("▶", () => _carouselController.nextPage()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// **🚀 Slide Design**
  Widget _buildSlide(
      String title, String image, List<String> features, List<String> buttons,
      {bool isPrivate = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(image, width: 250, fit: BoxFit.contain),
          const SizedBox(width: 30.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.oswald(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features.map((feature) => _buildFeatureItem(feature)).toList(),
                ),
                const SizedBox(height: 20.0),

                /// **Show buttons only for public projects**
                if (!isPrivate)
                  Wrap(
                    spacing: 10.0,
                    children: buttons
                        .map((buttonText) => _buildButton(
                              text: buttonText,
                              color: kPrimaryColor,
                              textColor: Colors.white,
                            ))
                        .toList(),
                  )
                else
                  /// **Private Project Notice**
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "Enterprise Solution - Hosted at Customer Site",
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
            ),
          ),
        ],
      ),
    );
  }

  /// **📌 Feature Item**
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: kPrimaryColor, size: 16.0),
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

  /// **🔘 Navigation Button**
  Widget _buildNavButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  /// **🔘 Button Design**
  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: TextButton(
        onPressed: () {}, // Add navigation link
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
