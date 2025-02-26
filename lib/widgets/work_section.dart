// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../core/repositories/projects_repository.dart';

class WorkSection extends StatefulWidget {
  final int index;
  final int activeIndex;
  const WorkSection({super.key, required this.index, required this.activeIndex});

  @override
  _WorkSectionState createState() => _WorkSectionState();
}

class _WorkSectionState extends State<WorkSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ProjectsProvider>(context, listen: false).fetchProjects());
  }

  @override
  Widget build(BuildContext context) {
    var projectsProvider = Provider.of<ProjectsProvider>(context);
    var projects = projectsProvider.projects;
    
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "MY WORK",
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "A showcase of projects built with passion and innovation",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 50.0),
              projects.isEmpty
    ? CircularProgressIndicator(color: Colors.blueAccent)
    : Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: isMobile ? 0 : 20.0,
      runSpacing: 20.0,
      children: List.generate(
        projects.length,
        (index) {
          Widget projectBox = _buildProjectBox(projects[index], constraints, isMobile);
    
            return projectBox; // No animation if index ≠ activeIndex
          }
        
      ),
    ),

              ],
            );
          },
        ),
      ),
    );
  }
Widget _buildProjectBox(ProjectItem project, BoxConstraints constraints, bool isMobile) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: isMobile ? double.infinity : (constraints.maxWidth / 2) - 20.0,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.95),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          spreadRadius: 2,
          offset: Offset(3, 5),
        ),
      ],
      border: Border.all(color: Colors.grey.withOpacity(0.1)),
    ),
    child: _buildProjectCard(project),
  );
}

Widget _buildProjectCard(ProjectItem project) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Project Title
      Text(
        project.title.toUpperCase(),
        style: GoogleFonts.montserrat(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          letterSpacing: 1.2,
        ),
      ),
      const SizedBox(height: 12.0),

      // Features List
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: project.features.map((feature) => _buildFeatureItem(feature)).toList(),
      ),
      const SizedBox(height: 20.0),

      // Action Buttons
      if (!project.isPrivate)
        Wrap(
          spacing: 12.0,
          runSpacing: 8.0,
          children: project.buttons.map((buttonText) => _buildButton(text: buttonText)).toList(),
        )
      else
        _buildPrivateTag(),
    ],
  );
}

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.purple, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
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
        backgroundColor: Colors. purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      onPressed: () {},
      child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.0, fontWeight: FontWeight.w600)),
    );
  }
Widget _buildPrivateTag() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lock, color: Colors.redAccent, size: 16),
        const SizedBox(width: 6),
        Text(
          "Enterprise Solution (Private)",
          style: GoogleFonts.montserrat(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

}