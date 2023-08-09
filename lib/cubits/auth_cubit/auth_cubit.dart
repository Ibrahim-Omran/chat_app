
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit() : super(AuthInitial());


  Future<void> loginUser({required String email,required String password}) async {

    emit(LoginLoading());

    try {
      UserCredential user = await FirebaseAuth.instance.
      signInWithEmailAndPassword(
        email: email,
        password: password,);

      emit(LoginSuccess());

    }on FirebaseAuthException catch (ex) {
      //  عشان اظهر رسالة لليوزر تقولة ان في خطاء
      switch (ex.code) {
        case "user-not-found":
          emit(LoginFailure(errMessage: 'user not found'));
          break;
        case "wrong-password":
          emit(LoginFailure(errMessage: 'wrong password'));
          break;
      }
    }
    catch(e){
      emit(LoginFailure(errMessage: 'something went wrong'));
    }
  }




  Future<void> registerUser({required String email,required String password}) async {

    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(
        email: email,
        password: password,);
      emit(RegisterSuccess());
    }on FirebaseAuthException catch (ex) {
      //  عشان اظهر رسالة لليوزر تقولة ان في خطاء
      switch (ex.code) {
        case "user-not-found":
          emit(RegisterFailure(errMessage: 'user not found'));
          break;
        case "wrong-password":
          emit(RegisterFailure(errMessage: 'wrong password'));
          break;
      }
    }catch(e){
      emit(RegisterFailure(errMessage: 'something went wrong'));
    }
  }



}