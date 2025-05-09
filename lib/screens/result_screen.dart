import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> analysisResult = [
    {
      "문장": "현 시설물 상태에서 임대차한다.",
      "위험도": 3,
      "위험사항 여부": "예",
      "위험 사유": "현재 상태로 임대한다는 조항은 추후 시설물 하자에 대한 임대인의 책임을 면제할 수 있어, 세입자에게 불리함."
    },
    {
      "문장": "임차인은 위 부동산에 존재하는 모든 법적 회계(담보권, 저당권, 임차권 등)로 인하여 경매 등이 실행될 경우 임차보증금의 전부 또는 일부를 반환받지 못할 수도 있다.",
      "위험도": 5,
      "위험사항 여부": "예",
      "위험 사유": "세입자가 임차보증금을 전부나 일부 환급받지 못하는 위험이 있음. 관련 법률에 대한 이해가 없으면, 세입자가 손실을 입을 수 있음."
    },
    {
      "문장": "임대할 부분의 면적은 (공부상 실측면적)이다.",
      "위험도": 1,
      "위험사항 여부": "아니오",
      "위험 사유": ""
    },
    {
      "문장": "기타사항은 민법 임대차보호법 관례에 따르기로 한다.",
      "위험도": 1,
      "위험사항 여부": "아니오",
      "위험 사유": ""
    },
    {
      "문장": "한사람이 거주하며 애완동물사는 금지다.",
      "위험도": 2,
      "위험사항 여부": "아니오",
      "위험 사유": ""
    },
  ];

  Color _riskColor(int risk) {
    if (risk >= 4) return Colors.red.shade300;
    if (risk == 3) return Colors.orange.shade300;
    return Colors.green.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("계약서 분석 결과"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: analysisResult.length,
        itemBuilder: (context, index) {
          final item = analysisResult[index];
          return Card(
            color: _riskColor(item["위험도"]),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("문장: ${item["문장"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("위험도: ${item["위험도"]}"),
                  Text("위험사항 여부: ${item["위험사항 여부"]}"),
                  if (item["위험 사유"] != null && item["위험 사유"].toString().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text("⚠ 위험 사유: ${item["위험 사유"]}"),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          icon: const Icon(Icons.home),
          label: const Text("홈으로"),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xFF6F73EA),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
