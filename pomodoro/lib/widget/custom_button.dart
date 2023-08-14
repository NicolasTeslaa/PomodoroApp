import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomButtom({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 200,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ));
  }
}
