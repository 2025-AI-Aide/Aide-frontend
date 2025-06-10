import 'package:flutter/material.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B7EFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B7EFF),
        elevation: 0,
        title: const Text(
          '게시판',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 헤더 섹션
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                // 메뉴 버튼들
                _buildMenuButton(
                  icon: Icons.edit_document,
                  title: '새 글 작성',
                  subtitle: '게시글 작성하기',
                  onTap: () {
                    // 새 글 작성 화면으로 이동
                    print('새 글 작성 클릭');
                  },
                ),
                const SizedBox(height: 16),

                _buildMenuButton(
                  icon: Icons.list_alt,
                  title: '전체 게시글',
                  subtitle: '모든 게시글 보기',
                  onTap: () {
                    // 전체 게시글 화면으로 이동
                    print('전체 게시글 클릭');
                  },
                ),
                const SizedBox(height: 16),

                _buildMenuButton(
                  icon: Icons.person,
                  title: '인기 게시글 보기',
                  subtitle: '조회수',
                  onTap: () {
                    // 내가 쓴 글 화면으로 이동
                    print('내가 쓴 글 클릭');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 사용 예시 - main.dart 또는 다른 위젯에서
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '게시판 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSans', // 한글 폰트 설정 (선택사항)
      ),
      home: const BoardScreen(),
    );
  }
}