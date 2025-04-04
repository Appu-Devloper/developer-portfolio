
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../repositories/services_repository.dart';

class ServiceCard extends StatefulWidget {
  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: isHovered ? Border.all(color: widget.service.color.withValues(alpha: 0.7), width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 15,
              spreadRadius: -3,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.service.icon, size: 50, color: widget.service.color.withValues(alpha: 0.8)),
              SizedBox(height: 12),
              Text(
                widget.service.title,
                 textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.service.description,
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: widget.service.features
                    .map(
                      (feature) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: widget.service.color.withValues(alpha:0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          feature,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
