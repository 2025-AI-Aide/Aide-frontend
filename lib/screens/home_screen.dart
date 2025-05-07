import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        title: const Text("AI 전세 계약서 분석"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              const Text(
                "전세계약서 AI검토로\n계약을 안전하게",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // 계약서 검토 버튼
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/upload');
                },
                icon: const Icon(Icons.document_scanner, size: 32),
                label: const Text(
                  "전세계약서 검토 &\n위험성 진단",
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F73EA),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 65),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),

              const SizedBox(height: 20),

              // 셀프 체크 리스트 버튼
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/checklist');
                },
                icon: const Icon(Icons.check_circle_outline, size: 30),
                label: const Text(
                  "셀프 체크 리스트",
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9497EB),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 65),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),

              const SizedBox(height: 20),

              // 전세사기 가이드 버튼
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/guide');
                },
                icon: const Icon(Icons.info_outline, size: 30),
                label: const Text(
                  "전세사기 예방 가이드",
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB8BAF4),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 65),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),

              const SizedBox(height: 40),
              const Text(
                "AI 기술을 활용하여 안전한 전세 계약을 도와드립니다.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
