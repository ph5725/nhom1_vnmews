import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nhom1_vnmews/data/model/nguontin_model.dart';

class ReadDataNT {
  Future<List<NguonTinModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/nguontin.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => NguonTinModel.fromJson(e)).toList();
  }

  // Phương thức loadDataById để lấy dữ liệu theo id từ file JSON
  Future<NguonTinModel> loadDataById(int id) async {
    // Tải dữ liệu từ file JSON
    var data = await rootBundle.loadString("assets/files/nguontin.json");

    var dataJson = jsonDecode(data);

    // Lọc ra nguồn tin có id tương ứng
    var item = (dataJson['data'] as List)
        .map((e) => NguonTinModel.fromJson(e))
        .firstWhere((element) => element.id == id, orElse: () => throw Exception('Không tìm thấy nguồn tin với id $id'));

    return item;
  }
}