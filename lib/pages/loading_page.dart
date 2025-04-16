import 'dart:io';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_page.dart';

class LoadingPage extends StatefulWidget {
  final File image;

  LoadingPage({required this.image});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  void _analyzeImage() async {
    final result = await ApiService.uploadImage(widget.image);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultPage(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
