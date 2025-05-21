import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? selectedFile;

  // 사진 촬영
  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _goToAnalyzeScreen(File(pickedFile.path));
    }
  }

  // 사진 업로드 (갤러리)
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _goToAnalyzeScreen(File(pickedFile.path));
    }
  }

  // PDF 업로드
  Future<void> _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      _goToAnalyzeScreen(File(result.files.single.path!));
    }
  }

  void _goToAnalyzeScreen(File file) {
    Navigator.pushNamed(context, '/analyze', arguments: file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        title: const Text("계약서 업로드"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_file, size: 100, color: Color(0xFF6F73EA)),
            const SizedBox(height: 30),
            const Text(
              "AI 검토로 계약을 확인하세요",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              '하단의 버튼을 눌러 업로드 방식을 선택하세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _UploadButton(
                  icon: Icons.camera_alt,
                  label: '사진 촬영',
                  onTap: _takePhoto,
                ),
                _UploadButton(
                  icon: Icons.file_upload,
                  label: '사진 업로드',
                  onTap: _pickImage,
                ),
                _UploadButton(
                  icon: Icons.picture_as_pdf,
                  label: 'PDF 업로드',
                  onTap: _pickPDF,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _UploadButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _UploadButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B81EA),
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
