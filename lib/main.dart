import 'package:book_list_1/screens/tabs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(
      //  useMaterial3: false,
      //  fontFamily: 'Cinzel',
      //  textTheme: TextTheme(
      //  bodyMedium: TextStyle(fontWeight: FontWeight.w500),
      //  titleLarge: TextStyle(fontWeight: FontWeight.w800),
  //),
//),
      home: TabsScreen()
    );
  }
}
