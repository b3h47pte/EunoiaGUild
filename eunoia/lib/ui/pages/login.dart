import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:eunoia/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool get hasLoginToken => Uri.base.queryParameters.containsKey('token');

  _init() async {
    if (hasLoginToken) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      // Login to Firebase using the token in the URI if we have one.
      await FirebaseAuth.instance.signInWithCustomToken(Uri.base.queryParameters['token']!);

      // Now redirect to the home page again.
      Future(() {
        GoRouter.of(context).go('/');
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children  = [];
    if (hasLoginToken) {
      children = [
        Center(child: SizedBox(width: 200, height: 200, child: CircularProgressIndicator()))
      ];
    } else {
      children = [
          Center(
            child: Text(
              'Please Login using Discord.',
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          ),
          Center(
            child: Text(
              'You must already be in the Eunoia Discord server.',
              style: TextStyle(
                fontSize: 24.0,
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          ),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.discord,
                color: Colors.white,
                size: 24.0,
              ),
              label: Text('Login with Discord'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0)
              ),
              onPressed: () {
                html.window.open('${AppConfig.of(context)!.apiUrl}/auth/discord', '_self');
              },
            ),
          )
        ];
    }


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      )
    );
  }
}