import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({this.onChange,this.hintText, this.obscureText =false,});
  String? hintText;
  Function(String)? onChange;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(

        obscureText: obscureText!,
        validator: (data){
          if(data!.isEmpty){
            return 'field is required';
          }
        },

        style: const TextStyle(
          color: Colors.white
        ),


        onChanged: onChange ,

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),

          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),

        ),
      ),
    );
  }
}
