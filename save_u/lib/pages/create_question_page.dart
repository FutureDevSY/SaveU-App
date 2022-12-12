import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({Key? key}) : super(key: key);

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  // TextField의 값을 가져올 때 사용합니다.
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  // 경고 메세지
  String? titleE, contentE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("질문 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "질문 제목",
                errorText: titleE,
              ),
            ),
            TextField(
              controller: contentController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "질문 내용",
                errorText: contentE,
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String title = titleController.text;
                  String content = contentController.text;
                  if (title.isEmpty) {
                    setState(() {
                      titleE = "제목을 입력해주세요.";
                      contentE = null;
                    });
                  } else if (content.isEmpty) {
                    setState(() {
                      titleE = null;
                      contentE = "내용을 입력해주세요."; // 내용이 없는 경우 에러 메세지
                    });
                  } else {
                    setState(() {
                      titleE = null;
                      contentE = null; // 내용이 있는 경우 에러 메세지 숨기기
                    });
                    Navigator.pop(context,
                        {"title": title, "content": content}); // 화면을 종료합니다.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
