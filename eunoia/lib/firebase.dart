import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> initializeFirebase(bool useEmulator) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (useEmulator) {
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
  }

  // Wait for us to get a logged in user if any.
  await FirebaseAuth.instance.authStateChanges().timeout(Duration(seconds: 2)).first;
}