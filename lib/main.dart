import 'package:dev_connect/Screens/OnBoardingScreen.dart';
import 'package:dev_connect/Screens/TabScreens/TabsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? _token = prefs.getString('token');

  runApp(MaterialApp(
    title: "Dev Connect",
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    home: _token != null ? const TabsScreen() : const OnboardingScreen(),
  ));
}
