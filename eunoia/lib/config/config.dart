import 'package:flutter/cupertino.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    Key? key,
    required this.apiUrl,
    required Widget child,
  }) : super(key: key, child: child);

  final String apiUrl;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}