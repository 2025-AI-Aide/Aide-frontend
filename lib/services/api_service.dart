import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/analysis_model.dart';

class APIService {
  static const String _baseUrl = 'http://10.0.2.2:8080'; // Emulator 기준
  //static const String _baseUrl = 'http://211.114.113.223:8080'; // Emulator 기준

  static Future<List<ContractAnalysis>> analyzeContract(File file) async {
    final uri = Uri.parse('$_baseUrl/api/contract/upload');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final Map<String, dynamic> jsonData = jsonDecode(respStr);

      final String rawText = jsonData['message'] ?? '';

      // 2줄 띄어쓰기 기준 블록 나누기
      final blocks = rawText.split(RegExp(r'\n{2,}')).where((e) => e.trim().isNotEmpty);

      final List<ContractAnalysis> parsed = blocks.map((block) {
        final sentence = RegExp(r"문장: (.+)").firstMatch(block)?.group(1)?.trim() ?? '';
        final riskLevel = int.tryParse(RegExp(r"위험도: (\d+)").firstMatch(block)?.group(1) ?? '0') ?? 0;
        final hasRisk = RegExp(r"위험사항 여부: (예|아니오)").firstMatch(block)?.group(1) ?? '아니오';
        final reason = RegExp(r"위험 사유: (.+)").firstMatch(block)?.group(1)?.trim() ?? '';

        return ContractAnalysis.fromJson({
          'sentence': sentence,
          'riskLevel': riskLevel,
          'hasRisk': hasRisk,
          'reason': reason,
        });
      }).toList();

      return parsed;
    } else {
      throw Exception('서버 오류: ${response.statusCode}');
    }
  }
}
