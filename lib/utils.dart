import 'package:flutter/material.dart';
import 'package:msn/powersync.dart';

class Utils {
  const Utils._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await openDatabase();
    /*  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ); */
  }
}
