import 'package:flutter/material.dart';
import 'package:v4/screens/auth/api/auth_api.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String? email;
  late String? username;
  TextEditingController bioTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final AuthAPI appwrite = context.read<AuthAPI>();
    email = appwrite.email;
    username = appwrite.username;
    appwrite.getUserPreferences().then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          bioTextController.text = value.data['bio'];
        });
      }
    });
  }

  savePreferences() {
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.updatePreferences(bio: bioTextController.text);
    const snackbar = SnackBar(
        content: Text('Preferences updated!',
            style: TextStyle(color: Colors.white)));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  signOut() {
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Account",
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
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                signOut();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Welcome back $username!',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 24)),
                  Text('$email', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 40),
                  Card(
                    color: const Color(0xff1E2127),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        TextField(
                          controller: bioTextController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Your Bio',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => savePreferences(),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Save Preferences',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              )),
        ));
  }
}
