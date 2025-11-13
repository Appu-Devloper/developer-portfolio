import 'package:developer_portfolio/presentation/widgets/section_shell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../core/repositories/services_repository.dart';
import '../core/utils/service_card.dart';

class ServicesScreen extends StatefulWidget {
  final int index;
  final int activeIndex;

  const ServicesScreen({
    super.key,
    required this.index,
    required this.activeIndex,
  });

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Fetch services when the screen loads
    Future.microtask(
      () =>
          Provider.of<ServicesProvider>(context, listen: false).fetchServices(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var servicesProvider = Provider.of<ServicesProvider>(context);
    var services = servicesProvider.services;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: SectionShell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "OUR SERVICES",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 26.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Innovative solutions tailored for your success",
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40.0),
              services.isEmpty
                  ? const CircularProgressIndicator()
                  : AnimationLimiter(
                    child: Wrap(
                      spacing: 30.0,
                      runSpacing: 30.0,
                      alignment: WrapAlignment.center,
                      children:
                          services
                              .asMap()
                              .entries
                              .map(
                                (entry) => AnimationConfiguration.staggeredGrid(
                                  position: entry.key,
                                  columnCount: 3,
                                  child: SlideAnimation(
                                    verticalOffset: 40,
                                    child: FadeInAnimation(
                                      child: ServiceCard(service: entry.value),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
