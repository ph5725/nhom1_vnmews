import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/user_model.dart';
import 'package:nhom1_vnmews/page/taikhoan/dangnhap.dart';
import 'package:path_provider/path_provider.dart';

class DangKyWidget extends StatefulWidget {
  const DangKyWidget({super.key});

  @override
  State<DangKyWidget> createState() => _DangKyWidgetState();
}

class _DangKyWidgetState extends State<DangKyWidget> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _phoneController = TextEditingController();

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

  Future<void> _writeUsers(List<Map<String, dynamic>> users) async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    await file.writeAsString(jsonEncode(users));
  }

  UserModel getUser() {
    return UserModel(
      fullname: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      pass: _passController.text,
    );
  }

  Future<bool> saveUserToFile(UserModel objUser) async {
    try {
      List<Map<String, dynamic>> users = await _readUsers();

      if (users.any((user) => user['email'] == objUser.email)) {
        throw Exception('Email đã tồn tại');
      }

      int newId = users.isNotEmpty ? users.length + 1 : 1;
      Map<String, dynamic> newUser = objUser.toJson();
      newUser['id'] = newId;

      users.add(newUser);
      await _writeUsers(users);
      return true;
    } catch (e) {
      debugPrint('Error saving user: $e');
      return false;
    }
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
      
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Đăng ký tài khoản",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 60, 107, 124),
                  ),
                ),
                const SizedBox(height: 20),

                // Name
                _buildTextField(
                  controller: _nameController,
                  label: "Tên hiển thị",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên hiển thị';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Email
                _buildTextField(
                  controller: _emailController,
                  label: "Email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return 'Email không đúng định dạng';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Phone
                _buildTextField(
                  controller: _phoneController,
                  label: "Số điện thoại",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (!RegExp(r"^\d{10,11}$").hasMatch(value)) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Password
                _buildTextField(
                  controller: _passController,
                  label: "Mật khẩu",
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Confirm Password
                _buildTextField(
                  controller: _confirmPassController,
                  label: "Xác nhận mật khẩu",
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng xác nhận mật khẩu';
                    }
                    if (value != _passController.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Register Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserModel objUser = getUser();

                      if (await saveUserToFile(objUser)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đăng ký thành công!')),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DangNhapWidget(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đăng ký thất bại!')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 60, 107, 124),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Đăng ký",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                // Login Suggestion
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn đã có tài khoản? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DangNhapWidget(),
                          ),
                        );
                      },
                      child: const Text(
                        "Đăng nhập",
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 60, 107, 124)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      validator: validator,
    );
  }
}
