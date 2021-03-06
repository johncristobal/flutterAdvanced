import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType type;
  final bool isPass;

  const CustomInput({
    Key? key, 
    required this.icon, 
    required this.placeholder, 
    required this.textController, 
    this.type = TextInputType.text, 
    this.isPass = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0,5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.type,
        obscureText: this.isPass,
        decoration: InputDecoration(
          prefixIcon: Icon( this.icon ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder
        ),
      ),
    );
  }
}