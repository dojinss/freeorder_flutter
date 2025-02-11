import 'package:flutter/material.dart';

class CustomSnackbar {
  final String text;
  final IconData icon;
  final int duration;
  final Color color;
  final Color backgroundColor;
  final EdgeInsets margin;

  CustomSnackbar({
    required this.text,
    this.icon = Icons.info,
    this.duration = 3,
    this.color = Colors.white,
    this.backgroundColor = Colors.blueAccent,
    EdgeInsets? margin, // nullable로 변경
  }) : margin = margin ?? const EdgeInsets.fromLTRB(0, 0, 0, 73); // 초기화 리스트에서 기본값 설정

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ),
        duration: Duration(seconds: duration),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
