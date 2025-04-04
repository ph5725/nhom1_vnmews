import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/tintuc_model.dart';

class TinTucVM with ChangeNotifier{
  List<TinTucModel> lst = [];

  //Thêm 1 item vào danh sách
  add(TinTucModel tt) {
    lst.add(tt);
    notifyListeners();
  }

  //Xóa vị trí
  del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }

  //Xóa cả danh sách
  allDel() {
    lst.clear();
  notifyListeners();
  }
}