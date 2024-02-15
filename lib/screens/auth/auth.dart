import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E1219),
      appBar: AppBar(
          title: Text(
            "Auth",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          backgroundColor: const Color(0xff0E1219),
          iconTheme: const IconThemeData(color: Color(0xffffffff)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: const SafeArea(
        child: Center(
          child: Text(
            "Auth",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff)),
          ),
        ),
      ),
    );
  }
}
