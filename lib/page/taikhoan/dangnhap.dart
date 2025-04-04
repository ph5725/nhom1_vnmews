import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/provider/auth_provider.dart';
import 'package:nhom1_vnmews/page/trangchu/trangchu_widget.dart';
import 'package:nhom1_vnmews/page/taikhoan/dangky.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DangNhapWidget extends StatefulWidget {
  const DangNhapWidget({super.key});

  @override
  State<DangNhapWidget> createState() => _DangNhapWidgetState();
}

class _DangNhapWidgetState extends State<DangNhapWidget> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/user.json";
  }

  Future<List<Map<String, dynamic>>> _readUsers() async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    if (!await file.exists()) {
      await file.writeAsString(jsonEncode([]));
    }

    final content = await file.readAsString();
    return List<Map<String, dynamic>>.from(jsonDecode(content));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 60, 107, 124),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                      .hasMatch(value)) {
                    return 'Email không đúng định dạng';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(
                  labelText: "Mật khẩu",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text;
                  final password = _passController.text;

                  final authProvider = Provider.of<AuthProvider>(context, listen: false);

                  if (await authProvider.verifyPassword(email, password)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng nhập thành công!')),
                    );

                    authProvider.login(); // Đăng nhập thành công
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrangChuWidget()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email hoặc mật khẩu không đúng!')),
                    );
                  }
                }
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 60, 107, 124),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Đăng nhập"),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Bạn chưa có tài khoản? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DangKyWidget(),
                        ),
                      );
                    },
                    child: const Text(
                      "Đăng ký",
                      style: TextStyle(
                        color: Color.fromARGB(255, 60, 107, 124),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
