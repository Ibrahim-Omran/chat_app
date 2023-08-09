import 'package:chat_room/Screens/auth/login_screen.dart';
import 'package:chat_room/Screens/auth/registar_screen.dart';
import 'package:chat_room/widget/button_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String id = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/chat.png',
                height: 85,
                width: 80,
              ),

              const Text(
                'My Chat',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50,),

          Button(
              namButton: 'log in',
            onTap: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          const SizedBox(height: 30,),

          Button(
            namButton: 'Register',
            onTap: (){
              Navigator.pushNamed(context, RegisterScreen.id);

            },
          ),

        ],
      ),
    );
  }
}
