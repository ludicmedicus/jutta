import 'package:flutter/material.dart';
class MyButton extends StatelessWidget{
  final Icon icon;
  final void Function()? onPressed;
  const MyButton({super.key, this.onPressed, required this.icon});
  bool get hasOnpressed => onPressed != null;


@override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: icon);
  }
}