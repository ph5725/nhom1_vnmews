import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/provider/auth_provider.dart';
import 'package:nhom1_vnmews/page/taikhoan/doimatkhau.dart';
import 'package:nhom1_vnmews/page/trangchu/trangchu_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TaiKhoanWidget extends StatelessWidget {
  const TaiKhoanWidget({super.key});

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/user.json";
  }

  Future<Map<String, dynamic>?> _getCurrentUser() async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    if (await file.exists()) {
      final content = await file.readAsString();
      final users = List<Map<String, dynamic>>.from(jsonDecode(content));

      if (users.isNotEmpty) {
        // Lấy người dùng cuối cùng (hoặc logic khác nếu cần)
        return users.last;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Đã xảy ra lỗi: \${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color.fromARGB(255, 60, 107, 124),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Thông tin tài khoản",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 60, 107, 124),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(50, 200, 234, 209),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tên hiển thị: ${user['fullname']}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Divider(height: 40, color: Colors.grey),
                          Text(
                            "Email: ${user['email']}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Divider(height: 40, color: Colors.grey),
                          Text(
                            "Số điện thoại: ${user['phone']}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoiMatKhauWidget(currentUser: user),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 60, 107, 124),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Đổi mật khẩu",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Provider.of<AuthProvider>(context, listen: false)
                                .logout();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TrangChuWidget(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 60, 107, 124),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Đăng xuất",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Không tìm thấy dữ liệu người dùng.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}
