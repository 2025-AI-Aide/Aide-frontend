import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("사용 가이드"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: "기본 사용 방법",
              content: [
                "1. 홈 화면에서 '계약서 분석하기' 버튼을 클릭합니다.",
                "2. 카메라 또는 갤러리에서 계약서 사진을 선택합니다.",
                "3. 분석 결과를 확인하고 필요한 조치를 취하세요.",
              ],
            ),
            SizedBox(height: 24),
            _buildSection(
              title: "사진 촬영 가이드",
              content: [
                "• 계약서의 모든 페이지를 포함하도록 촬영해주세요.",
                "• 조명이 충분한 곳에서 촬영을 권장합니다.",
                "• 계약서의 중요한 부분이 잘 보이도록 촬영해주세요.",
                "• 각 페이지를 분리하여 촬영하는 것이 좋습니다.",
              ],
            ),
            SizedBox(height: 24),
            _buildSection(
              title: "분석 결과 해석",
              content: [
                "• 리스크 점수: 계약서의 위험도를 0-100으로 표시합니다.",
                "  - 0-30: 안전한 계약서",
                "  - 31-70: 주의가 필요한 계약서",
                "  - 71-100: 위험한 계약서",
                "• 주요 위험 요인: 발견된 위험 요소들을 상세히 설명합니다.",
                "• 개선 제안: 계약서를 개선하기 위한 제안사항을 제공합니다.",
                "• 법률 용어: 계약서에서 사용된 법률 용어의 설명을 제공합니다.",
              ],
            ),
            SizedBox(height: 24),
            _buildSection(
              title: "주의사항",
              content: [
                "• 분석 결과는 참고용이며, 법률적 조언을 받으시려면 전문가와 상담해주세요.",
                "• 계약서의 모든 내용을 자세히 확인해주세요.",
                "• 분석 결과는 계약서의 표면적인 내용만을 기반으로 합니다.",
                "• 계약서 외적인 사항(임대인의 신용도 등)도 고려해야 합니다.",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> content,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...content.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}