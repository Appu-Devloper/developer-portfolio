import 'package:developer_portfolio/sections/work_section.dart';
import 'package:developer_portfolio/presentation/widgets/animated_background.dart';
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
    const url =
        'https://drive.google.com/file/d/1OsgwhMoAMdSRXodqqAC2kgUaai6Wz34P/view';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool useDrawer = width < 860;

    return AnimatedPortfolioBackground(
      child: Scaffold(
        key: Globals.scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: _buildGlassAppBar(context, useDrawer),
        endDrawer: useDrawer ? _buildDrawer(context) : null,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(key: _keys[0], child: const HomeScreen()),
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
                  const SizedBox(height: 50),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: _buildScrollFab(),
      ),
    );
  }

  PreferredSizeWidget _buildGlassAppBar(BuildContext context, bool useDrawer) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(86),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 72,
              backgroundColor: Colors.white.withValues(alpha: 0.85),
              titleSpacing: 20,
              leadingWidth: useDrawer ? 56 : 0,
              leading:
                  useDrawer
                      ? IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.black87,
                        ),
                        onPressed:
                            () =>
                                Globals.scaffoldKey.currentState
                                    ?.openEndDrawer(),
                      )
                      : null,
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      "AM",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Appu M",
                        style: GoogleFonts.montserrat(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Software Development Engineer",
                        style: GoogleFonts.montserrat(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                if (!useDrawer) ...[
                  _buildNavButton("Home", _keys[0], 0),
                  _buildNavButton("About", _keys[1], 1),
                  _buildNavButton("Services", _keys[2], 2),
                  _buildNavButton("Work", _keys[3], 3),
                  _buildNavButton("Skills", _keys[4], 4),
                  _buildResumeButton(),
                  const SizedBox(width: 12),
                ] else
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: FilledButton.icon(
                      onPressed: _launchResumeURL,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade400,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.picture_as_pdf_outlined),
                      label: const Text("Resume"),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Navigate",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Jump to any section instantly",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerNavButton("Home", _keys[0], 0),
                  _buildDrawerNavButton("About", _keys[1], 1),
                  _buildDrawerNavButton("Services", _keys[2], 2),
                  _buildDrawerNavButton("Work", _keys[3], 3),
                  _buildDrawerNavButton("Skills", _keys[4], 4),
                ],
              ),
            ),
            _buildResumeButton(expanded: true),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildResumeButton({bool expanded = false}) {
    final button = ElevatedButton.icon(
      onPressed: _launchResumeURL,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6A11CB),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
      label: Text(
        "Resume",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );

    return Padding(
      padding:
          expanded
              ? const EdgeInsets.fromLTRB(24, 8, 24, 20)
              : const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: SizedBox(width: expanded ? double.infinity : null, child: button),
    );
  }

  Widget _buildScrollFab() {
    return FloatingActionButton.extended(
      onPressed: _scrollToTop,
      backgroundColor: Colors.deepPurple.shade400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      icon: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
      label: Text(
        "Back to top",
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// **Navigation Bar Buttons**
  Widget _buildNavButton(String label, GlobalKey sectionKey, int index) {
    final bool isSelected = _activeIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
      child: InkWell(
        onTap: () => _scrollToSection(sectionKey),
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color:
                isSelected
                    ? Colors.purple.withValues(alpha: 0.12)
                    : Colors.transparent,
            border: Border.all(
              color:
                  isSelected
                      ? Colors.purple.withValues(alpha: 0.4)
                      : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.purple : Colors.black26,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerNavButton(String label, GlobalKey sectionKey, int index) {
    final bool isSelected = _activeIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          _scrollToSection(sectionKey);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:
                isSelected
                    ? Colors.deepPurple.withValues(alpha: 0.12)
                    : Colors.white,
            border: Border.all(
              color: Colors.deepPurple.withValues(
                alpha: isSelected ? 0.4 : 0.15,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.bolt_rounded,
                size: 18,
                color: isSelected ? Colors.deepPurple : Colors.black54,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}
