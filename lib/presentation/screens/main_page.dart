import 'package:developer_portfolio/sections/work_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../sections/footer_section.dart';
import '../../sections/home_section.dart';
import '../../sections/about_section.dart';
import '../../sections/skill_section.dart';
import '../../sections/services.dart';
import '../../core/utils/globals.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0; // Track the currently visible section

  // Create unique GlobalKeys for each container
  final List<GlobalKey> _keys = List.generate(5, (index) => GlobalKey());

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

  /// Function to Scroll to the Top
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _launchResumeURL() async {
    const url = 'https://drive.google.com/file/d/1Qt69Vx4b0q1FYg70Yiiq2blsuvczrsLe/view';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: Globals.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "<Appu M />",
          style: GoogleFonts.alexBrush(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
         actions: MediaQuery.of(context).size.width > 600
            ? [
                _buildNavButton("Home", _keys[0], 0),
                _buildNavButton("About", _keys[1], 1),
                _buildNavButton("Services", _keys[2], 2),
                _buildNavButton("Work", _keys[3], 3),
                _buildNavButton("Skills", _keys[4], 4),
                OutlinedButton(
                  onPressed: _launchResumeURL,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.purple),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  ),
                  child: Text(
                    "Resume",
                    style: GoogleFonts.montserrat(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ]
            : [ Builder(
  builder: (context) => IconButton(
    icon: Icon(Icons.menu, color: Colors.black87),
    onPressed: () {
      Scaffold.of(context).openEndDrawer();
    },
  ),
),
]
      ),
      endDrawer: MediaQuery.of(context).size.width <= 600
          ? Drawer(
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                 _buildNavButton1("Home", _keys[0], 0),
                 SizedBox(height: 10),
                _buildNavButton1("About", _keys[1], 1),
SizedBox(height: 10),
                _buildNavButton1("Services", _keys[2], 2),SizedBox(height: 10),
                _buildNavButton1("Work", _keys[3], 3),SizedBox(height: 10),
                _buildNavButton1("Skills", _keys[4], 4),SizedBox(height: 10),
                SizedBox(width: 120,
                  child: OutlinedButton(
                    onPressed: _launchResumeURL,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.purple),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    ),
                    child: Text(
                      "Resume",
                      style: GoogleFonts.montserrat(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                
                ],
              ),
            )
          : null,
      
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(key: _keys[0], child: HomeScreen()),
            Container(
              key: _keys[1],
              child: AboutMeScreen(index: 1, activeIndex: _activeIndex),
            ),
            Container(
              key: _keys[2],
              child: ServicesScreen(index: 2, activeIndex: _activeIndex),
            ),
            Container(
              key: _keys[3],
              child: WorkSection(index: 3, activeIndex: _activeIndex),
            ),
            Container(
              key: _keys[4],
              child: SkillSection(index: 4, activeIndex: _activeIndex),
            ),
            
           
            SizedBox(height: 50),
            FooterSection()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Colors.black54,
        child: Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }

  /// **Navigation Bar Buttons**
  Widget _buildNavButton(String label, GlobalKey sectionKey, int index) {
    bool isSelected = _activeIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () => _scrollToSection(sectionKey),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: 4),
                height: 2,
                width: 60,
                color: Colors.purple,
              ),
          ],
        ),
      ),
    );
  }
   Widget _buildNavButton1(String label, GlobalKey sectionKey, int index) {
    bool isSelected = _activeIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () { _scrollToSection(sectionKey);Navigator.pop(context);},
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.purple.withValues(alpha: 0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 120,height: 35,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSelected
                      ? [Colors.deepPurple, Colors.purpleAccent]
                      : [Colors.white, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: Border.all(
                  color: isSelected?Colors.white: Colors.purple,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.purpleAccent.withValues(alpha: 0.3),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.montserrat(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
