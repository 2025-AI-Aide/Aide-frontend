
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/upload_screen.dart';
import '../screens/result_screen.dart';
import '../screens/guide_screen.dart';
import '../screens/analyze_screen.dart';
import '../screens/board.dart';
import '../screens/checklist_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/board': (context) => HomeScreen(),
  '/upload': (context) => UploadScreen(),
  '/analyze': (context) => AnalyzeScreen(),
  '/result': (context) => ResultScreen(),
  '/checklist': (context) =>ChecklistScreen(),
  '/guide': (context) => GuideScreen(),
  '/': (context) => BoardScreen()
};