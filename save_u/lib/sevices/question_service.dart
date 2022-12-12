import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class QuestionService extends ChangeNotifier {
  final questionCollection = FirebaseFirestore.instance.collection('question');

  Future<DocumentSnapshot> readOne(String docId) async {
    // 선택한 question
    return questionCollection.doc(docId).get();
  }

  Future<QuerySnapshot> read(String uid) async {
    // 내 questionList 가져오기
    return questionCollection.where('uid', isEqualTo: uid).get();
  }

  Future<QuerySnapshot> readAll() async {
    // 모든 questionList 가져오기
    return questionCollection.get();
  }

  void create(String title, String content, String uid) async {
    //uuid 생성
    var uuid = Uuid();

    //현재 날짜 받아오기
    var now = DateTime.now();
    String formatDate = DateFormat('yy-MM-dd HH:mm:ss').format(now);

    await questionCollection.doc(uuid.v1()).set({
      'uid': uid, // 유저 식별자
      'title': title, // 제목
      'content': content, // 내용
      'date': formatDate,
    });
  }

  void update(String docId, String title, String content) async {
    await questionCollection
        .doc(docId)
        .update({'title': title, 'content': content});
    notifyListeners();
  }

  void delete(String docId) async {
    await questionCollection.doc(docId).delete();
    notifyListeners();
  }
}
