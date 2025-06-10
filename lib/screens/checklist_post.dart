import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ChecklistPostScreen extends StatefulWidget {
  const ChecklistPostScreen({super.key});

  @override
  State<ChecklistPostScreen> createState() => _ChecklistPostScreenState();
}

class _ChecklistPostScreenState extends State<ChecklistPostScreen> {
  final List<bool> _checked = List.filled(3, false);
  final List<bool> _expanded = List.filled(3, false);

  final List<Map<String, dynamic>> checklistItems = [
    {
      'title': '임대차 신고',
      'main': '임대차 계약 체결 후 30일 이내 의무 신고',
      'details': [
        '신고 대상: 보증금 6천만 원 또는 월세 30만 원 초과 시',
        '신고 장소: 주민센터 또는 온라인(https://www.rentalhousing.go.kr)',
        '⚠️ 미신고 시 과태료 최대 100만 원 부과 가능',
      ],
    },
    {
      'title': '전입신고',
      'main': '주민등록 전입신고는 권리 보호를 위한 필수 절차',
      'details': [
        '전입신고 장소: 주민센터 또는 정부24(https://www.gov.kr)',
        '전입신고 완료 후 확정일자 받아야 우선변제권 확보 가능',
      ],
    },
    {
      'title': '전세보증금 반환보증 가입',
      'main': '보증금을 돌려받기 위한 안전장치',
      'details': [
        '가입처: HUG(https://www.khug.or.kr), SGI(https://www.sgic.co.kr)',
        '가입 시기: 계약 직후 또는 입주 전 가능',
        '⚠️ 미가입 시 임대인 파산 등으로 반환 어려움 발생 가능',
      ],
    },
  ];

  int get checkedCount => _checked.where((e) => e).length;

  Color getProgressColor(double ratio) {
    if (ratio >= 0.75) return Colors.green;
    if (ratio >= 0.4) return Colors.orange;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final ratio = checkedCount / _checked.length;
    final allChecked = checkedCount == _checked.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("계약 후 체크리스트"),
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "진행도: $checkedCount / ${_checked.length} (${(ratio * 100).round()}%)",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: ratio,
              color: getProgressColor(ratio),
              backgroundColor: Colors.grey.shade300,
              minHeight: 8,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: checklistItems.length,
                itemBuilder: (context, i) {
                  final item = checklistItems[i];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ExpansionTile(
                      initiallyExpanded: _expanded[i],
                      onExpansionChanged: (val) => setState(() => _expanded[i] = val),
                      leading: Checkbox(
                        value: _checked[i],
                        onChanged: (val) => setState(() => _checked[i] = val!),
                      ),
                      title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['main'],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 8),
                              ...item['details'].map<Widget>((d) {
                                return _buildDetailText(d);
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: allChecked
                  ? () {
                Navigator.pop(context); // 또는 Navigator.pushNamed(context, '/nextPage');
              }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: const Color(0xFF9B81EA),
                disabledBackgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.check_circle),
              label: const Text("모두 완료했어요"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailText(String text) {
    final urlRegex = RegExp(r'(https?://[^\s)]+)');
    final spans = <TextSpan>[];

    text.splitMapJoin(
      urlRegex,
      onMatch: (match) {
        final url = match[0]!;
        spans.add(TextSpan(
          text: ' ($url)',
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
        ));
        return '';
      },
      onNonMatch: (nonMatch) {
        final isWarning = nonMatch.trim().startsWith('⚠️');
        spans.add(TextSpan(
          text: nonMatch,
          style: TextStyle(
            color: isWarning ? Colors.deepOrange : Colors.black87,
            fontWeight: isWarning ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13.5,
          ),
        ));
        return '';
      },
    );

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 6),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: spans),
      ),
    );
  }
}
