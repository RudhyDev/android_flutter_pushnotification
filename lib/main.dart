import 'package:android_flutter_pushnotification/api/firebase_api.dart';
import 'package:android_flutter_pushnotification/firebase_options.dart';
import 'package:android_flutter_pushnotification/pages/notification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:android_flutter_pushnotification/pages/homepage.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const HomePage(), navigatorKey: navigatorKey, routes: {
      '/notification_screen': (context) => const NotificationPage(),
    });
  }
}
