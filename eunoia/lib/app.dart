import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:eunoia/ui/pages/login.dart';
import 'package:eunoia/ui/pages/404.dart';
import 'package:firebase_auth/firebase_auth.dart';
class EunoiaApp extends StatelessWidget {
  EunoiaApp({Key? key}) : super(key: key);

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      )
    ],
    errorBuilder: (context, state) => const Error404Page(),
    redirect: (state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      final onLogonPage = state.subloc == '/login';
      if (isLoggedIn && onLogonPage) {
        return '/';
      } else if (!isLoggedIn && !onLogonPage) {
        return '/login';
      }
      return null;
    },
    urlPathStrategy: UrlPathStrategy.path,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: ThemeData.dark(),
    );
  }
}