import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nhom1_vnmews/data/model/tintuc_model.dart';

// 1. Đọc dữ liệu tin tức về Ẩm thực
class RDAmThuc {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/amThuc.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 2. Đọc dữ liệu tin tức về Công nghệ
class RdCongNghe {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/congNghe.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 3. Đọc dữ liệu tin tức về Du lịch
class RDDuLich {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/duLich.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 4. Đọc dữ liệu tin tức về Giải trí
class RDGiaiTri {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/giaiTri.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 5. Đọc dữ liệu tin tức về Giáo dục
class RDGiaoDuc {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/giaoDuc.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 6. Đọc dữ liệu tin tức về Kinh tế
class RDKinhTe {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/kinhTe.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 7. Đọc dữ liệu tin tức về Nóng
class RDNong {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/nong.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 8. Đọc dữ liệu tin tức về Pháp luật
class RDPhapLuat {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/phapLuat.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 9. Đọc dữ liệu tin tức về Sức khỏe
class RDSucKhoe {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/sucKhoe.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 10. Đọc dữ liệu tin tức về Thế giới
class RDTheGioi {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/theGioi.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 11. Đọc dữ liệu tin tức về Thế giới xe
class RDTheGioiXe {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/theGioiXe.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 12. Đọc dữ liệu tin tức về Thể thao
class RDTheThao {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/theThao.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 13. Đọc dữ liệu tin tức về Thiết bị
class RDThietBi {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/thietBi.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 14. Đọc dữ liệu tin tức về Thời sự
class RDThoiSu {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/thoiSu.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}

// 15. Đọc dữ liệu tin tức về Thời trang
class RDThoiTrang {
  Future<List<TinTucModel>> loadData() async {
    var data = await rootBundle.loadString(
      "assets/files/vietnam_news/thoiTrang.json"
    );

    var dataJson = jsonDecode(data);

    return (dataJson['articles'] as List).map((e) => TinTucModel.fromJson(e)).toList();
  }
}