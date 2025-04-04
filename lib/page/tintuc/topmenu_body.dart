import 'package:flutter/material.dart';

Widget topMenuBody(
  String label, {
  bool isLast = false,
  required VoidCallback onPressed,
  required bool isSelected, // Thêm isSelected vào đây
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          shape: RoundedRectangleBorder( // Để có góc bo tròn cho nút
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color.fromARGB(255, 60, 107, 124):  const Color.fromARGB(255, 126, 126, 126), // Màu chữ thay đổi khi được chọn
            fontSize: isSelected? 16 : 15,
            fontWeight: isSelected? FontWeight.w900 : FontWeight.w400
          ),
        ),
      ),
    ],
  );
}