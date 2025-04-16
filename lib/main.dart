import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '전세사기 예방',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
