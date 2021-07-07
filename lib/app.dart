import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'theme/shopping_app_theme.dart';

class ShoppingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ShoppingAppTheme.buildLightTheme(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
