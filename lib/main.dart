import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI 전세 계약서 분석',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',         // 첫 시작은 홈 화면
      routes: appRoutes,         // 라우트 등록
    );
  }
}