import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> uploadImage(File image) async {
    final uri = Uri.parse('http://<FLASK_SERVER_IP>:5000/analyze'); // 🔁 Flask 서버 주소로 바꾸기
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // Flask 백엔드에서 받는 필드명과 일치해야 함
        image.path,
      ),
    );

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        throw Exception('서버 오류: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('요청 실패: $e');
    }
  }
}
