import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import '../services/api_service.dart'; // 파일 경로에 맞게 import

class AnalyzeScreen extends StatefulWidget {
  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  bool _isLoading = false;
  late File file;
  bool _hasValidFile = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is File) {
      file = args;
    } else {
      _hasValidFile = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("잘못된 파일 정보입니다.")),
        );
        Navigator.pop(context);
      });
    }
  }

  Future<void> _startAnalysis(File file) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await APIService.analyzeContract(file);
      Navigator.pushNamed(context, '/result', arguments: result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("분석 실패: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isImage(String filePath) {
    final ext = filePath.toLowerCase();
    return ext.endsWith('.png') ||
        ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.heic');
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasValidFile) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        title: const Text("계약서 분석"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "업로드한 계약서를 AI가 분석합니다",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: _isImage(file.path)
                    ? Image.file(file, fit: BoxFit.contain, width: double.infinity)
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.picture_as_pdf, size: 150, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(
                      path.basename(file.path),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: _isLoading
            ? const SizedBox(height: 60, child: Center(child: CircularProgressIndicator()))
            : ElevatedButton.icon(
          onPressed: () => _startAnalysis(file),
          icon: const Icon(Icons.analytics),
          label: const Text("AI 분석하기", style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9B81EA),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
