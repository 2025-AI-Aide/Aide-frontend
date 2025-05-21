
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class APIService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/contract/upload'; // 실제 서버 주소로 교체

  static Future<Map<String, dynamic>> analyzeContract(File file) async {
    final uri = Uri.parse('$_baseUrl');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    if (response.statusCode == 200) {

      final respStr = await response.stream.bytesToString();

      return jsonDecode(respStr);
    } else {
      throw Exception('서버 오류: ${response.statusCode}');
    }
  }
}