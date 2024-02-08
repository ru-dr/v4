import 'package:flutter/material.dart';
import 'package:v4/screens/Home/home.dart';
import 'package:v4/screens/translate/translate.dart';
import 'package:v4/screens/weather/weather.dart';
import 'package:v4/screens/hospital/hospital.dart';
import 'package:v4/screens/emergency/emergency.dart';
import 'package:v4/screens/ticket/ticket.dart';
import 'package:v4/screens/explore/explore.dart';
import 'package:v4/screens/auth/auth.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'v4',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/translate': (context) => const Translate(),
        '/weather': (context) => const Weather(),
        '/hospital': (context) => const Hospital(),
        '/emergency': (context) => const Emergency(),
        '/ticket': (context) => const Ticket(),
        '/explore': (context) => const Explore(),
        '/auth': (context) => const Auth(),
      },
    );
  }
}
