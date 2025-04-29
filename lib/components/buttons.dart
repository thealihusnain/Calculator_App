import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback onPress;

  const MyButtons({
    Key? key,
    required this.title,
    this.color,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: onPress,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? Colors.grey[300],
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: color != null ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}