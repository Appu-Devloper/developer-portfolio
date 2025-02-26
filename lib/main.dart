import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';

import 'core/repositories/experience_repository.dart';
import 'core/repositories/projects_repository.dart';
import 'core/repositories/services_repository.dart';
import 'presentation/screens/implementation.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => ProjectsProvider()),
         ChangeNotifierProvider(create: (context) => ExperienceProvider()),
        ChangeNotifierProvider(create: (_) => ServicesProvider()), // Register Service Provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Portfolio",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
     
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
