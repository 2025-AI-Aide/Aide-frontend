import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> result =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("분석 결과"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "AI 분석 결과",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/')),
              icon: const Icon(Icons.home),
              label: const Text("홈으로"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9B81EA),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
