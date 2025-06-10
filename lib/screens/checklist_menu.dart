import 'package:flutter/material.dart';

class ChecklistMenuScreen extends StatelessWidget {
  const ChecklistMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전세계약 체크리스트"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C4FF4),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "전세계약을 위한 체크 리스트를 확인해 보세요",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildChecklistCard(
              context,
              icon: Icons.search,
              label: "계약 전 체크리스트",
              onTap: () => Navigator.pushNamed(context, '/checklist_pre'),
            ),
            const SizedBox(height: 20),
            _buildChecklistCard(
              context,
              icon: Icons.description,
              label: "계약 중 ai 계약서 분석",
              onTap: () => Navigator.pushNamed(context, '/upload'),
            ),
            const SizedBox(height: 20),
            _buildChecklistCard(
              context,
              icon: Icons.fact_check,
              label: "계약 후 체크리스트",
              onTap: () => Navigator.pushNamed(context, '/checklist_post'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistCard(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF2C4FF4), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 30, color: const Color(0xFF2C4FF4)),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2C4FF4),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
