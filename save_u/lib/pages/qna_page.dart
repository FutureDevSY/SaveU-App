import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_u/pages/create_question_page.dart';
import 'package:save_u/sevices/auth_service.dart';
import 'package:save_u/sevices/question_service.dart';

import 'qna_details_page.dart';

class QnAPage extends StatefulWidget {
  const QnAPage({super.key});

  @override
  State<QnAPage> createState() => _QnAPageState();
}

class _QnAPageState extends State<QnAPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionService>(
      builder: (context, questionService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;

        return Scaffold(
          appBar: AppBar(
            title: Text("Q&A"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Map<String, String>? question = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateQuestionPage()),
              );
              if (question != null) {
                setState(() {
                  questionService.create(
                      question['title']!, question['content']!, user.uid);
                });
              }
            },
            child: const Icon(Icons.add),
          ),
          body: user.email == null
              ? Text("로그인 후 이용 가능합니다.")
              : Column(
                  children: [
                    /// 질문 리스트
                    Expanded(
                      child: FutureBuilder<QuerySnapshot>(
                          future: questionService.readAll(),
                          builder: (context, snapshot) {
                            final documents =
                                snapshot.data?.docs ?? []; // 문서들 가져오기
                            if (documents.isEmpty) {
                              return Center(child: Text("질문이 없습니다."));
                            }
                            return ListView.builder(
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                final doc = documents[index];
                                String title = doc.get('title');
                                String content = doc.get('content');
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                QnADetailsPage(
                                              questionId: doc.id,
                                            ),
                                          ),
                                        );
                                      },
                                      title: Text(
                                        "Q. $title",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(6.0),
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
                          }),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
