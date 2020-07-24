import 'package:flutter/material.dart';
import 'package:ravelinestores/screens/base/base_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Raveline's Stores",
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          accentColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: AppBarTheme(elevation: 0.0)),
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
    );
  }
}
