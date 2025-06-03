
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/upload_screen.dart';
import '../screens/result_screen.dart';
import '../screens/guide_screen.dart';
import '../screens/analyze_screen.dart';
import '../screens/checklist_menu.dart';
import '../screens/checklist_post.dart';
import '../screens/checklist_pre.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomeScreen(),
  '/upload': (context) => UploadScreen(),
  '/analyze': (context) => AnalyzeScreen(),
  '/result': (context) => ResultScreen(),
  '/checklist_menu': (context) => const ChecklistMenuScreen(),
  '/checklist_pre': (context) => const ChecklistPreScreen(),
  '/checklist_post': (context) => const ChecklistPostScreen(),
  '/guide': (context) => GuideScreen(),
};