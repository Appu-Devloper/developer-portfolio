import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';

import 'services/experience_provider.dart';
import 'services/services_provider.dart';
import 'utils/home.dart';
import 'utils/constants.dart'; // Import your Service Provider

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => ExperienceProvider()),
        ChangeNotifierProvider(create: (_) => ServicesProvider()), // Register Service Provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Portfolio",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        platform: TargetPlatform.android,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryColor,
        canvasColor: backgroundColor,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: MainPage(),
    );
  }
}
