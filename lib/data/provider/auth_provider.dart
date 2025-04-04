// import 'package:flutter/material.dart';

// class AuthProvider with ChangeNotifier {
//   bool _isLoggedIn = false; // Mặc định chưa đăng nhập

//   bool get isLoggedIn => _isLoggedIn;

//   // Hàm xử lý đăng nhập
//   void login() {
//     _isLoggedIn = true;
//     notifyListeners(); // Thông báo cập nhật
//   }

//   // Hàm xử lý đăng xuất
//   void logout() {
//     _isLoggedIn = false;
//     notifyListeners(); // Thông báo cập nhật
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false; // Mặc định chưa đăng nhập

  bool get isLoggedIn => _isLoggedIn;

  // Hàm xử lý đăng nhập
  void login() {
    _isLoggedIn = true;
    notifyListeners(); // Thông báo cập nhật
  }

  // Hàm xử lý đăng xuất
  void logout() {
    _isLoggedIn = false;
    notifyListeners(); // Thông báo cập nhật
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/user.json";
  }

  Future<List<Map<String, dynamic>>> _readUsers() async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    if (!await file.exists()) {
      await file.writeAsString(jsonEncode([])); // Tạo file rỗng nếu chưa tồn tại
    }

    final content = await file.readAsString();
    return List<Map<String, dynamic>>.from(jsonDecode(content));
  }

  // Hàm kiểm tra mật khẩu
  Future<bool> verifyPassword(String email, String password) async {
    final users = await _readUsers();

    for (var user in users) {
      if (user['email'] == email && user['pass'] == password) {
        return true;
      }
    }
    return false;
  }
}
