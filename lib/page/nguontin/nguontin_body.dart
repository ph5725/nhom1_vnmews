import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/conf/const.dart';
import 'package:nhom1_vnmews/data/model/nguontin_model.dart';
import 'package:nhom1_vnmews/page/nguontin/thongtin_widget.dart';

Widget nguonTinBody(NguonTinModel item, BuildContext context) {

  return Card(
    margin: const EdgeInsets.all(8),
    elevation: 4,
    child: InkWell(
      onTap: () {
        // Chuyển sang trang ThongTinWidget và truyền id của nguồn tin
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThongTinWidget(idNguonTin: item.id ?? -1),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Nếu có ảnh, bạn có thể hiển thị nó
          Image.asset(
            urlNguonBao + item.img!, // Đường dẫn đến hình ảnh
            width: 80,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 8),

          Text(
            item.name ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
