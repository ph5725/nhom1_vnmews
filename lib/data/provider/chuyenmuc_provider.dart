import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nhom1_vnmews/data/model/chuyenmuc_model.dart';

class ReadDataCM {
  Future<List<ChuyenMucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/chuyenmuc.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => ChuyenMucModel.fromJson(e)).toList();
  }
}