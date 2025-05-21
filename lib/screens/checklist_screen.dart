import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final List<bool> _checked = List.filled(9, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("계약 시 임차인 체크리스트"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "전세계약 전 반드시 확인해야 할 항목을 체크해보세요",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTile(
                    0,
                    "공인중개사 정상 영업 여부",
                    "· 공인중개사무소 등록 현황 확인 (국토부 등록정보, 포털 등)\n"
                        "· 개업공인중개사 자격증, 중개보조원 신분 확인",
                  ),
                  _buildTile(
                    1,
                    "임대인(대리인) 신분 확인",
                    "· 임대인과 임차인 사이 위임장, 인감증명서로 권한 확인\n"
                        "· 계약 체결자와 소유자 불일치 시 관계 증빙 필요",
                  ),
                  _buildTile(
                    2,
                    "주택 상태 확인",
                    "· 건물 하자 여부, 전기·가스·수도 사용 여부 확인\n"
                        "· 도어락, 보일러, 창문 등 작동 상태 점검",
                  ),
                  _buildTile(
                    3,
                    "적정 시세 확인",
                    "· 한국부동산원, 네이버부동산, KB부동산 등에서 유사 매물 비교",
                  ),
                  _buildTile(
                    4,
                    "선순위 권리관계 확인",
                    "· 등기부등본 열람 후 근저당권, 전세권, 가압류 유무 확인",
                  ),
                  _buildTile(
                    5,
                    "임대인 세금 체납 여부",
                    "· 주민센터, 홈택스 통해 국세·지방세 체납 여부 확인 가능",
                  ),
                  _buildTile(
                    6,
                    "주택임대차표준계약서 활용",
                    "· 권리관계 및 특약이 명시된 계약서 양식 사용 권장",
                  ),
                  _buildTile(
                    7,
                    "전세보증금 반환보증보험 가입 여부",
                    "· HUG, SGI 등 보증가입 가능 여부 확인",
                  ),
                  _buildTile(
                    8,
                    "계약 후 체크리스트",
                    "· 전입신고 및 확정일자 받기 (30일 이내)\n· 보증보험 가입 신청",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("홈으로"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final count = _checked.where((c) => c).length;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("체크한 항목: $count / 9")),
                      );
                    },
                    child: const Text("전체 확인"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F73EA),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(int index, String title, String detail) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Checkbox(
          value: _checked[index],
          onChanged: (val) => setState(() => _checked[index] = val!),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(detail, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}