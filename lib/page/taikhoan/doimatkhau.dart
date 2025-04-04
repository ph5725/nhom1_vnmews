import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:nhom1_vnmews/data/provider/auth_provider.dart';

class DoiMatKhauWidget extends StatefulWidget {
  final Map<String, dynamic> currentUser;

  const DoiMatKhauWidget({required this.currentUser, super.key});

  @override
  State<DoiMatKhauWidget> createState() => _DoiMatKhauWidgetState();
}

class _DoiMatKhauWidgetState extends State<DoiMatKhauWidget> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Future<void> _updatePassword(String email, String newPassword) async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    final users = await _readUsers();

    // Cập nhật mật khẩu cho tài khoản có email khớp
    for (var user in users) {
      if (user['email'] == email) {
        user['pass'] = newPassword;
        break;
      }
    }

    await file.writeAsString(jsonEncode(users));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: const Color.fromRGBO(60, 107, 124, 0.514),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/logo/logochu.png",
              height: 30,
            ),

            const SizedBox(height: 50,),
          ],
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mật khẩu cũ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu cũ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mật khẩu mới'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu mới';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Xác nhận mật khẩu mới'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng xác nhận mật khẩu mới';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Mật khẩu xác nhận không khớp';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = widget.currentUser['email'];
                    final oldPassword = _oldPasswordController.text;
                    final newPassword = _newPasswordController.text;

                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);

                    if (await authProvider.verifyPassword(email, oldPassword)) {
                      // Nếu mật khẩu cũ đúng, cập nhật mật khẩu mới
                      await _updatePassword(email, newPassword);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cập nhật mật khẩu thành công!')),
                      );

                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Mật khẩu cũ không chính xác!')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 60, 107, 124),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Cập nhật mật khẩu',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
