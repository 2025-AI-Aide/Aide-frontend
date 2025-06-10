import 'package:flutter/material.dart';
import '../models/analysis_model.dart';

class ResultScreen extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool highExpanded = true;
  bool mediumExpanded = false;
  bool lowExpanded = false;

  @override
  Widget build(BuildContext context) {
    final List<ContractAnalysis> results =
    ModalRoute.of(context)!.settings.arguments as List<ContractAnalysis>;

    final highRisk = results.where((e) => e.riskLevel >= 4).toList();
    final mediumRisk = results.where((e) => e.riskLevel == 3).toList();
    final lowRisk = results.where((e) => e.riskLevel <= 2).toList();

    String getOverallStatus() {
      if (highRisk.isNotEmpty) return "주의 필요";
      if (mediumRisk.isNotEmpty) return "신중한 검토 필요";
      return "안전";
    }

    Color getOverallColor() {
      if (highRisk.isNotEmpty) return Colors.red;
      if (mediumRisk.isNotEmpty) return Colors.orange;
      return Colors.green;
    }

    Widget buildRiskGroup(String title, Color color, List<ContractAnalysis> items, bool expanded, Function(bool) onToggle) {
      if (items.isEmpty) return const SizedBox.shrink();

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$title (${items.length})",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          trailing: Icon(expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: color),
          initiallyExpanded: expanded,
          onExpansionChanged: onToggle,
          children: items.map((item) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.sentence, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  if (item.reason.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(item.reason, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        title: const Text("계약서 분석 결과"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.description_outlined, size: 30),
                      SizedBox(width: 10),
                      Text("계약서 분석 결과", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "AI가 계약서를 분석한 결과입니다.\n아래 내용을 확인해 주세요.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: getOverallColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          highRisk.isNotEmpty
                              ? "위험도: 높음"
                              : (mediumRisk.isNotEmpty ? "위험도: 중간" : "위험도: 낮음"),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: getOverallColor(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(getOverallStatus(), style: const TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  buildRiskGroup("위험도 높음", Colors.red, highRisk, highExpanded, (bool v) => setState(() => highExpanded = v)),
                  buildRiskGroup("위험도 중간", Colors.orange, mediumRisk, mediumExpanded, (bool v) => setState(() => mediumExpanded = v)),
                  buildRiskGroup("위험도 낮음", Colors.green, lowRisk, lowExpanded, (bool v) => setState(() => lowExpanded = v)),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed:() => Navigator.pushNamed(context,'/upload'),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: const Text("계약서 다시 업로드", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context,'/'),
                    icon: const Icon(Icons.home),
                    label: const Text("홈화면으로", style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B81EA),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
