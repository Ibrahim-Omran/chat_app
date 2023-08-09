
import 'package:chat_room/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/auth/login_screen.dart';
import 'Screens/auth/registar_screen.dart';
import 'Screens/chat_screen.dart';
import 'Screens/home_screen.dart';
import 'cubits/auth_cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(
            create: (context) => AuthCubit()),
          BlocProvider(
              create: (context) => ChatCubit()),
    ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,

      routes:{
        HomeScreen.id : (context)=> HomeScreen(),
        RegisterScreen.id : (context)=> RegisterScreen(),
        LoginScreen.id : (context)=> LoginScreen(),
        ChatScreen.id:(context)=> ChatScreen(),

      },
      initialRoute: HomeScreen.id,
    ),
    );
  }
}

