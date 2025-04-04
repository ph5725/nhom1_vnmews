import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/chuyenmuc_model.dart';
import 'package:nhom1_vnmews/data/provider/auth_provider.dart';
import 'package:nhom1_vnmews/data/provider/chuyenmuc_provider.dart';
import 'package:nhom1_vnmews/page/default_widget.dart';
import 'package:nhom1_vnmews/page/nguontin/nguontin_widget.dart';
import 'package:nhom1_vnmews/page/tincuaban/tincuaban_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/tintuc_widget.dart';
import 'package:nhom1_vnmews/page/taikhoan/dangnhap.dart';
import 'package:nhom1_vnmews/page/taikhoan/taikhoan_widget.dart';
import 'package:provider/provider.dart';

class TrangChuWidget extends StatefulWidget {
  const TrangChuWidget({super.key});

  @override
  State<TrangChuWidget> createState() => _TrangChuWidgetState();
}

class _TrangChuWidgetState extends State<TrangChuWidget> {
  late Future<List<ChuyenMucModel>> futureCMList;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _loadWidget(int index) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        switch (index) {
          case 0:
            return const TinTucWidget();
          case 1:
            return const TinCuaBanWidget();
          case 2:
            return const NguonTinWidget();
          case 3:
            if (authProvider.isLoggedIn) {
              return const TaiKhoanWidget();
            } else {
              return const DangNhapWidget();
            }
          default:
            return const DefaultWidget(title: 'Chưa chọn mục');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo Future để tải dữ liệu
    futureCMList = ReadDataCM().loadData();
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

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "Tin tức",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Tin của bạn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label),
            label: "Nguồn tin",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Tài khoản",
          ),
        ],
        type: BottomNavigationBarType.fixed, // Luôn hiển thị label
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 60, 107, 124),
        unselectedItemColor: const Color.fromARGB(255, 124, 124, 124),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold, // In đậm cho mục được chọn
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal, // Bình thường cho mục không được chọn
        ),
        onTap: _onItemTapped,
      ),

      // Hiển thị widget tương ứng với BottomNavigationBar
      body: _loadWidget(_selectedIndex),
    );
  }
}
