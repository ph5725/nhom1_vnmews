import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/conf/const.dart';
import 'package:nhom1_vnmews/data/model/chuyenmuc_model.dart';

Widget trangChuBody(ChuyenMucModel item, BuildContext context) {
  return TextButton.icon(
    onPressed: () {
      const Text("Text was clicked!");
    },
    style: TextButton.styleFrom(
      alignment: Alignment.centerLeft, // Căn văn bản sang trái
    ),
    
    label: Row(
      children: [
        Image.asset(
          urlChuyenMuc + item.img!, // Đường dẫn đến hình ảnh
          width: 24, // Chiều rộng của icon
          height: 24, // Chiều cao của icon
        ),

        const SizedBox(width: 8),

        Text(
          item.name ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ]
    ),
  );
}