import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const CustomButton({Key? key, required this.onPressed,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 60,
      color: const Color(0xFe11e5376),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      child: Text(title,style: TextStyle(color: Colors.white),),
    );
  }
}
