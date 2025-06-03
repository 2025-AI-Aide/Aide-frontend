import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ChecklistPreScreen extends StatefulWidget {
  const ChecklistPreScreen({super.key});

  @override
  State<ChecklistPreScreen> createState() => _ChecklistPreScreenState();
}

class _ChecklistPreScreenState extends State<ChecklistPreScreen> {
  final List<bool> _checked = List.filled(7, false);
  final List<bool> _expanded = List.filled(7, false);

  final List<Map<String, dynamic>> checklistItems = [
    {
      'title': '공인 중개사 정상 영업 여부',
      'main': '공인중개사사무소 등록 현황 확인',
      'details': [
        '개업공인중개사, 소속공인중개사, 중개보조원 신분 확인',
        '네이버부동산https://land.naver.com, 브이월드https://www.vworld.kr 등에서 확인 가능',
      ],
    },
    {
      'title': '임대인(대리인) 신분 확인',
      'main': '임대인 또는 대리인의 신원 및 계약 권한 확인',
      'details': [
        '대리인 계약 시 위임장, 인감증명서 확인',
        '신탁 등기 시 수탁자가 계약 권한이 있는지 서류 확인 필요',
        '⚠️ 위임장 위조 사례 존재 → 인감증명서, 신탁원부 필수 확인',
      ],
    },
    {
      'title': '주택 상태',
      'main': '불법 건축물 및 주택 상태 점검',
      'details': [
        '건축물대장에서 용도 일치 여부 확인',
        '위반건축물 여부 확인 (건축물대장)',
        '보일러, 수도, 도어락, 전기 등 하자 유무 확인',
        '⚠️ 하자 발생 시 임대인의 하자보수 가능 여부 확인\n  및 특약사항에 명시 요구',
      ],
    },
    {
      'title': '적정 시세 확인',
      'main': '보증금이 적정한 수준인지 확인',
      'details': [
        '실거래가 공개시스템https://rt.molit.go.kr에서 시세 확인',
        '⚠️ 보증금이 시세의 80% 이상 시 위험 가능성 존재',
      ],
    },
    {
      'title': '선순위 권리관계 확인',
      'main': '보증금보다 선순위 채권 여부 확인',
      'details': [
        '등기부등본https://www.gov.kr 열람하여 근저당권, 전세권 등 선순위 채권 확인',
        '단독주택일 경우 전입세대 열람 필수',
        '⚠️ 보증금보다 선순위가 많으면 환급 어려움',
      ],
    },
    {
      'title': '임대인 세금 체납 여부',
      'main': '임대인의 체납 여부로 인한 위험 점검',
      'details': [
        '국세·지방세 완납증명서 요청 https://www.hometax.go.kr',
        '⚠️ 계약 후에는 동의 없이 국세 확인 가능 (체납 시 압류 위험)',
      ],
    },
    {
      'title': '주택임대차 표준계약서 활용',
      'main': '국토부 제공 표준계약서 사용',
      'details': [
        '특약 조항 포함 여부 확인',
        '표준계약서 다운로드 https://www.molit.go.kr',
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
        title: const Text("계약 전 체크리스트"),
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
          text: "$nonMatch",
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
