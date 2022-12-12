import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_u/pages/my_question_page.dart';
import 'package:save_u/pages/no_user_page.dart';

import '../sevices/auth_service.dart';
import 'login_page.dart';
import '../main.dart';
import 'my_scrap_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
      final user = authService.currentUser();
      const IconData login = IconData(0xe3b2, fontFamily: 'MaterialIcons');
      const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');
      return Scaffold(
        appBar: null,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    user == null ? "로그인이 필요합니다." : "${user.email}님",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (user == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        } else {
                          Widget cancelButton = TextButton(
                            child: Text("취소"),
                            onPressed: () {
                              Navigator.pop(context, "로그아웃 취소");
                            },
                          );
                          Widget continueButton = TextButton(
                            child: Text("로그아웃"),
                            onPressed: () {
                              context.read<AuthService>().signOut();
                              Navigator.pop(context, "로그아웃");
                            },
                          );

                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("로그아웃"),
                            content: Text("로그아웃 하시겠습니까?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                      },
                      icon: Icon(
                        user == null ? login : logout,
                      ))
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2, //탭 수
                child: Scaffold(
                  appBar: TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.blue,
                      tabs: <Widget>[
                        Tab(text: '내 스크랩'),
                        Tab(text: '내 질문'),
                      ]),
                  body: TabBarView(
                    children: <Widget>[
                      MyScrapPage(),
                      user == null ? NoUserPage() : MyQuestionPage(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
