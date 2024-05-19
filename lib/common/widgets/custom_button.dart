import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';

class CustomButton extends StatelessWidget {
 final String text;
 final VoidCallback onTap;
 const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text,),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(
              double.infinity, 50),
          backgroundColor: GlobalVariables.selectedNavBarColor,
          foregroundColor: Colors.white),
    );
  }
}
