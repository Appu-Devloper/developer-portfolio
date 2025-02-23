import 'package:developer_portfolio/widgets/work_section.dart';
import 'package:flutter/material.dart';
import '../widgets/home_section.dart';
import '../widgets/education_section.dart';
import '../widgets/services.dart';
import '/utils/globals.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Define Global Keys for each section
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _serviceskey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  // Scroll controller for smooth scrolling
  final ScrollController _scrollController = ScrollController();

  /// Function to Scroll to the Given Section
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: Globals.scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Fixed height for navbar
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.0,
          title: Text(
            "My Portfolio",
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            _buildNavButton("Home", _homeKey),
            _buildNavButton("About", _aboutKey),
            _buildNavButton("Education", _serviceskey),
            SizedBox(width: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(key: _homeKey, child: HomeScreen()),
            SizedBox(height: 50.0),
            Container(key: _aboutKey, child: AboutScreen()),
            SizedBox(height: 50.0),
           Container(key: _serviceskey, child: ServicesScreen()),
            Container(key: _workKey, child: IosAppAd()),
          ],
        ),
      ),
    );
  }

  /// **Navigation Bar Buttons**
  Widget _buildNavButton(String label, GlobalKey sectionKey) {
    return TextButton(
      onPressed: () => _scrollToSection(sectionKey),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
