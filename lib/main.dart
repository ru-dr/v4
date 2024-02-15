import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v4/screens/Home/home.dart';
import 'package:v4/screens/translate/translate.dart';
import 'package:v4/screens/weather/weather.dart';
import 'package:v4/screens/hospital/hospital.dart';
import 'package:v4/screens/emergency/emergency.dart';
import 'package:v4/screens/ticket/ticket.dart';
import 'package:v4/screens/explore/explore.dart';
import 'package:v4/screens/auth/auth.dart';
import 'package:v4/controllers/location_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff0E1219),
        textTheme: GoogleFonts.interTextTheme(
          // Use 'Inter' as the default font
          Theme.of(context).textTheme,
        ).copyWith(
          bodySmall: GoogleFonts.syne(
            // Use 'Syne' for body text
            textStyle: Theme.of(context).textTheme.bodySmall,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
          displayMedium: GoogleFonts.inter(
            // Use 'Barlow' for body text
            textStyle: Theme.of(context).textTheme.displayMedium,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'v4',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/translate': (context) => const Translate(),
        '/weather': (context) => const Weather(location: "Mehsana",),
        '/hospital': (context) => const Hospital(),
        '/emergency': (context) => const Emergency(),
        '/ticket': (context) => const Ticket(),
        '/explore': (context) => const Explore(),
        '/auth': (context) => const Auth(),
      },
    );
  }
}
