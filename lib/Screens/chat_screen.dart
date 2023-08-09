
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../const.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../cubits/chat_cubit/chat_state.dart';
import '../model/messages.dart';
import '../widget/buble_chat.dart';


class ChatScreen extends StatelessWidget {

  static String id = 'ChatPage';
  final _controllar = ScrollController();
  String? dataS;

  List<Message> messagesList = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String ;

    return Scaffold(
      backgroundColor:  Colors.grey[900],
      appBar: AppBar(
        // بيلغي سهم الرجوع للخلف
       automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset('assets/images/chat.png',height: 50,width: 50,),
            const SizedBox(width: 10,),
            const Text('My Chat Room'),
          ],
        )
      ),


      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit,ChatState>(

                builder: (context,state){
                  var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                  return ListView.builder(
                    reverse: true,
                    controller: _controllar,
                    itemCount: messagesList.length,
                    itemBuilder:(context,index){
                      return messagesList[index].id == email ? ChatBuble(
                        message: messagesList[index],
                      ) : ChatBubleForFriend(
                        message:messagesList[index],
                      );
                    },
                  );
                }
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(

              style: const TextStyle(
                  color: Colors.white
              ),
              onChanged: (data){
              dataS = data;
                },
              controller: controller,

              onSubmitted: (data){
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  message: data,
                  email: email,
                );




                controller.clear();
                //بيعمل اسكرور لتحت بعد مبعت الرسالة
                _controllar.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn
                );


              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: (){
                    BlocProvider.of<ChatCubit>(context).sendMessage(
                      message: dataS!,
                      email: email,
                    );





                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
                hintText: 'Send Message',
                hintStyle: TextStyle(
                  color: Colors.white
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}


