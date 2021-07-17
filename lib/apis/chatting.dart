import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlivrDriver/models/api_response/chat_m.dart';

abstract class ChatRepo {
  Stream<QuerySnapshot> watchChats(String chatId);
  Future<void> sendChat(ChatM chat, String jobId);
}

class ChatApis extends ChatRepo {
  final _chatStore = FirebaseFirestore.instance.collection('chats');

  @override
  Stream<QuerySnapshot> watchChats(String jobId) async* {
    yield* _chatStore
        .doc(jobId)
        .collection(jobId)
        .orderBy('time_stamp', descending: false)
        .snapshots();
  }

  @override
  Future<void> sendChat(ChatM chat, String jobId) async {
    chat.id = _chatStore.doc().id;
    await _chatStore
        .doc(jobId)
        .collection(jobId)
        .doc(chat.id)
        .set(chat.toJson());
  }
}
