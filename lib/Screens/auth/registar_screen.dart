import 'package:chat_room/Screens/chat_screen.dart';
import 'package:chat_room/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_room/cubits/auth_cubit/auth_state.dart';
import 'package:chat_room/widget/button_widget.dart';
import 'package:chat_room/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../cubits/chat_cubit/chat_cubit.dart';
import '../../hilper/snack_bar.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  static String id = 'RegisterScreen';

  String? email;
  String? password;
  bool isLoading = false;

   // عملت كي وحددت انه شغال معا الفورم
   GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context,state){
        if(state is RegisterLoading){
          isLoading = true ;
        }else if(state is RegisterSuccess){
          isLoading = false ;
          BlocProvider.of<ChatCubit>(context).getMessages();


          Navigator.pushNamed(context, ChatScreen.id,arguments: email);
        }else if(state is RegisterFailure){
          showSnackBar(context,state.errMessage);
          isLoading = false ;
        }

      },
      builder:(context,state) => ModalProgressHUD(
           inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor:  Colors.grey[900],
          appBar: AppBar(
            backgroundColor:  Colors.black,
            title: const Text(
              'My Chat'
            ),
          ),

          body: Form(
             key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100,),

                  Image.asset('assets/images/chat.png',
                    height: 120,
                    width: 120,
                  ),
                  //-----------------------------
                  const SizedBox(height: 80,),

                  CustomFormTextField(
                    hintText: 'Enter your Email..',
                    onChange: (data){
                      email = data;
                    },
                  ),
                  const SizedBox(height: 10,),


                  CustomFormTextField(
                    hintText: 'Enter your Password..',
                    onChange: (data){
                      password = data;
                    },
                    obscureText: true,

                  ),
                  const SizedBox(height: 30,),

                  Button(
                      namButton: 'Register' ,
                    onTap:  () async{
                      // من خلال الكي باكسس الحاله بتاعة الفورم وبعملها فلديت شوف البيانات صح ولا لا

                      if (formKey.currentState!.validate()) {
                        isLoading = true;

                        BlocProvider.of<AuthCubit>(context).registerUser(
                          email: email!,
                          password: password!,
                        );
                      }else{}

                    },
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
