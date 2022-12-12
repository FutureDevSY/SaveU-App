import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_u/sevices/comment_service.dart';
import 'package:save_u/sevices/question_service.dart';

import '../sevices/auth_service.dart';

class QnADetailsPage extends StatefulWidget {
  final String questionId;
  const QnADetailsPage({Key? key, required this.questionId}) : super(key: key);

  @override
  State<QnADetailsPage> createState() => _QnADetailsPageState();
}

class _QnADetailsPageState extends State<QnADetailsPage> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<QuestionService, CommentService>(
      builder: (context, questionService, commentService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;
        return Scaffold(
          appBar: null,
          body: Stack(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: questionService.readOne(widget.questionId),
                builder: (context, snapshot) {
                  final doc = snapshot.data!;
                  return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        // 아이콘, 익명, datetime
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Color(0xffE6E6E6),
                              child: Icon(
                                Icons.person,
                                color: Color(0xffCCCCCC),
                              ),
                            ),
                          ),
                          title: Text('익명 ${doc['uid'].substring(0, 1)}'),
                          subtitle: Text("${doc['date']}"),
                        ),
                        // 제목
                        Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            "Q. ${doc['title']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.4,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // 내용
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("${doc['content']}"),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        // 댓글 목록
                        Column(
                          children: [
                            SizedBox(
                              height: 500,
                              child: FutureBuilder<QuerySnapshot>(
                                future: commentService.read(widget.questionId),
                                builder: (context, snapshot) {
                                  final documents =
                                      snapshot.data?.docs ?? []; // 문서들 가져오기
                                  if (documents.isEmpty) {
                                    return Center(child: Text("아직 답변이 없습니다."));
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    //scrollDirection: Axis.horizontal,
                                    itemCount: documents.length,
                                    itemBuilder: (context, index) {
                                      final cdoc = documents[index];
                                      String uid = cdoc.get('uid');
                                      String content = cdoc.get('content');
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ListTile(
                                            title: Text(
                                              "익명 ${uid.substring(0, 1)}",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                content,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      /// 텍스트 입력창
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: "댓글을 입력해주세요.",
                          ),
                        ),
                      ),

                      /// 추가 버튼
                      ElevatedButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          // create comment
                          if (commentController.text.isNotEmpty) {
                            commentService.create(widget.questionId,
                                commentController.text, user.uid);
                          }
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
