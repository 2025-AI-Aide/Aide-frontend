  import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> result;

  ResultPage({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('분석 결과')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("🔍 위험 요소", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ...List.generate(result['risks'].length, (i) => Text("• ${result['risks'][i]}")),

          SizedBox(height: 20),

          Text("✅ 추천 특약", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ...List.generate(result['suggestions'].length, (i) => Text("• ${result['suggestions'][i]}")),
        ],
      ),
    );
  }
}
