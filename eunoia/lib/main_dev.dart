import 'package:flutter/material.dart';
import 'package:eunoia/config/config.dart';
import 'package:eunoia/app.dart';
import 'package:eunoia/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase(true);
  runApp(AppConfig(
    apiUrl: 'http://localhost:5001/eunoia-guild-manage/us-central1/api',
    child: EunoiaApp()
  ));
}