import 'package:flutter/material.dart';

import 'page/home_page.dart';
import 'page/style_photos_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Snapping',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.pinkAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        HomePage.route: (context) => HomePage(),
        StylePhotosPage.route: (context) => StylePhotosPage(),
      },
      initialRoute: HomePage.route,
    );
  }
}
