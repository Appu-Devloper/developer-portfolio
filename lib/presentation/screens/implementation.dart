import 'package:developer_portfolio/widgets/work_section.dart';
import 'package:flutter/material.dart';
import '../../widgets/home_section.dart';
import '../../widgets/about_section.dart';
import '../../widgets/services.dart';
import '../../core/utils/globals.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = -1; // Track the currently visible section

  // Create unique GlobalKeys for each container
  final List<GlobalKey> _keys = List.generate(4, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    for (int i = 0; i < _keys.length; i++) {
      RenderBox? renderBox =
          _keys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        Offset position = renderBox.localToGlobal(Offset.zero);
        double containerTop = position.dy;
        double containerBottom = containerTop + renderBox.size.height;

        double screenHeight = MediaQuery.of(context).size.height;
        double middleOfScreen = screenHeight / 2;

        if (containerTop <= middleOfScreen &&
            containerBottom >= middleOfScreen) {
          if (_activeIndex != i) {
            setState(() {
              _activeIndex = i;
            });
          }
          break;
        }
      }
    }
  }

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
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          actions: [
            _buildNavButton("Home", _keys[0]),
            _buildNavButton("About", _keys[1]),
            _buildNavButton("Services", _keys[2]),
            _buildNavButton("Work", _keys[3]),
            SizedBox(width: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(key: _keys[0], child: HomeScreen()),
            // Container(
            //   key: _keys[1],
            //   child: AboutMeScreen(index: 1, activeIndex: _activeIndex),
            // ),
            // Container(
            //   key: _keys[2],
            //   child: ServicesScreen(index: 2, activeIndex: _activeIndex),
            // ),
            Container(
              key: _keys[3],
              child: WorkSection(index: 3, activeIndex: _activeIndex),
            ),
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
