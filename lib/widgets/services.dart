import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/repositories/services_repository.dart';
import '../core/utils/service_card.dart';

class ServicesScreen extends StatefulWidget {
  final int index;
  final int activeIndex;

  const ServicesScreen({super.key, required this.index, required this.activeIndex});

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Fetch services when the screen loads
    Future.microtask(() => Provider.of<ServicesProvider>(context, listen: false).fetchServices());
  }

  @override
  Widget build(BuildContext context) {
    var servicesProvider = Provider.of<ServicesProvider>(context);
    var services = servicesProvider.services;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            "OUR SERVICES",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 26.0,
            ),
          ),
          const SizedBox(height: 8.0),

          // Tagline / Subtitle
          Text(
            "Innovative solutions tailored for your success", // You can customize this line
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 40.0),

          services.isEmpty
              ? CircularProgressIndicator() // Show loading indicator
              : Wrap(
                  spacing: 40.0,
                  runSpacing: 40.0,
                  alignment: WrapAlignment.center,
                  children: services.map((service) => ServiceCard(service: service)).toList(),
                ),
        ],
      ),
    );
  }
}
