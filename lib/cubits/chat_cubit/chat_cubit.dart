import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const.dart';
import '../../model/messages.dart';
import 'chat_state.dart';



class ChatCubit extends Cubit<ChatState>{
  ChatCubit() : super(ChatInitial());
  String? dataS;
  CollectionReference messages =
           FirebaseFirestore.instance.collection(kMessagesCollection);
  List<Message> messagesList = [];

  void sendMessage({required String message,required String email}){
    try {
      messages.add({
        kMessage: message, kCreadedAt: DateTime.now(), 'id': email,});
    }catch(e){
      if (kDebugMode) {
        print(kDebugMode.toString());
      }

    }
  }

  void getMessages(){         // بعمل ليسن عشان افضل سامع للرسايل لو حصل تغير
    messages.orderBy(kCreadedAt,descending: true).snapshots().listen((event){
      messagesList.clear();
      for(var doc in event.docs){
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));

    });
  }

}