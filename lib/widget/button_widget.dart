import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.onTap,required this.namButton});
  VoidCallback? onTap;
  String namButton;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan[800],
          borderRadius: BorderRadius.circular(50),
        ),
        width: 200,
        height: 55,
        child: Center(child: Text(
            namButton,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

        )),
      ),
    );
  }
}
