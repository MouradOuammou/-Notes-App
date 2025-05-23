import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final Widget icon;

  const CustomIconBtn({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);


}
