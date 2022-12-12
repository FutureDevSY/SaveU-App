import 'package:flutter/material.dart';

class NoUserPage extends StatelessWidget {
  const NoUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('로그인이 필요한 서비스입니다.\n 마이페이지에서 로그인 후 이용하세요.')),
    );
  }
}
