import 'package:flutter/material.dart';
import 'package:shopping_ui/screens/shopping_home_screen.dart';
import 'package:shopping_ui/theme/shopping_app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping UI',
      theme: HotelAppTheme.buildLightTheme(),
      home: ShoppingHomeScreen(),
    );
  }
}
