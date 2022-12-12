import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CommentService extends ChangeNotifier {
  final commentCollection = FirebaseFirestore.instance.collection('comment');

  Future<QuerySnapshot> read(String qid) async {
    // 질문에 대한 commentList 가져오기
    return commentCollection.where('qid', isEqualTo: qid).get();
  }

  void create(String qid, String content, String uid) async {
    //uuid 생성
    var uuid = Uuid();

    //현재 날짜 받아오기
    var now = DateTime.now();
    String formatDate = DateFormat('yy-MM-dd HH:mm:ss').format(now);

    await commentCollection.doc(uuid.v1()).set({
      'uid': uid, // 유저 식별자
      'qid': qid, // 제목
      'content': content, // 내용
      'date': formatDate,
    });
  }

  void delete(String docId) async {
    await commentCollection.doc(docId).delete();
    notifyListeners();
  }
}
