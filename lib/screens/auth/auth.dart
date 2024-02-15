import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v4/screens/auth/api/auth_api.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final AuthAPI authAPI = context.read<AuthAPI>();
      bool isLoggedIn = authAPI.status == AuthStatus.authenticated;
      String? username = authAPI.username;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Auth",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff0E1219),
          iconTheme: const IconThemeData(color: Color(0xffffffff)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Auth",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  if (!isLoggedIn) ...[
                    ElevatedButton(
                      child:
                          Text('Login', style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text('Register',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ] else ...[
                    Text(
                      'Welcome back $username!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Account',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/account');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    } catch (_) {
      // If an exception is thrown, navigate to the Auth page
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Container(); // Return an empty container while the navigation is not yet complete
    }
  }
}
