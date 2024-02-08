import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v4/screens/Emergency/emergency.dart';
import 'package:v4/screens/Explore/explore.dart';
import 'package:v4/screens/Hospital/hospital.dart';
import 'package:v4/screens/Ticket/ticket.dart';
import 'package:v4/screens/Translate/translate.dart';
import 'package:v4/screens/weather/weather.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomCard(
              svgIcon: 'assets/SVG/globe.svg',
              text: 'Translate',
              onTap: () {
                // redirect to translate page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Translate()),
                );
              },
              flex: 2,
              color: const Color(0xffF7C84C),
            ),
            const SizedBox(width: 5),
            CustomCard(
              svgIcon: 'assets/SVG/weather.svg',
              onTap: () {
                // redirect to translate page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Weather()),
                );
              },
              flex: 1,
              color: const Color(0xff5F6DF3),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            CustomCard(
              svgIcon: 'assets/SVG/hospital.svg',
              onTap: () {
                // redirect to translate page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Hospital()),
                );
              },
              flex: 1,
              color: const Color(0xffFFFFFF),
            ),
            const SizedBox(width: 5),
            CustomCard(
              svgIcon: 'assets/SVG/emergency.svg',
              text: 'Emergency',
              onTap: () {
                // redirect to translate page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Emergency()),
                );
              },
              flex: 2,
              color: const Color(0xffFC5750),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            CustomCard(
              svgIcon: 'assets/SVG/map.svg',
              text: 'Explore',
              onTap: () {
                // redirect to translate page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Explore()),
                );
              },
              flex: 2,
              color: const Color(0xff8AE990),
            ),
            const SizedBox(width: 5),
            CustomCard(
              svgIcon: 'assets/SVG/ticket.svg',
              onTap: () {
                // redirect to translate page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ticket()),
                );
              },
              flex: 1,
              color: const Color(0xffffffff),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String svgIcon;
  final String? text; // Make text nullable
  final VoidCallback onTap;
  final int flex;
  final Color color;

  const CustomCard({
    Key? key,
    required this.svgIcon,
    this.text, // No default value
    required this.onTap,
    this.flex = 1,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox(
        height: 90, // Set the height you want here
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgIcon,
                  width: 50,
                  height: 50,
                ),
                if (text != null) ...[
                  // Only render Text widget if text is not null
                  const SizedBox(width: 10),
                  Text(
                    text!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
