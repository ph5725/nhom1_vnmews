// import 'package:flutter/material.dart';
// import 'package:nhom1_vnmews/data/model/chuyenmuc_model.dart';
// import 'package:nhom1_vnmews/data/provider/chuyenmuc_provider.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/amthuc_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/congnghe_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/dulich_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/giaitri_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/giaoduc_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/kinhte_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/nong_.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/phapluat_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/suckhoe_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/thegioi_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/thegioixe_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/thethao_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/thietbi_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/thoisu_widget.dart';
// import 'package:nhom1_vnmews/page/BaoTiengViet/tintuc/chuyenmuc/thoitrang_widget.dart';

// class DanhSachBaoWidget extends StatefulWidget {
//   const DanhSachBaoWidget({super.key});

//   @override
//   State<DanhSachBaoWidget> createState() => _DanhSachBaoWidgetState();
// }

// class _DanhSachBaoWidgetState extends State<DanhSachBaoWidget> {
//   late Future<List<ChuyenMucModel>> cmList;

//   // Danh sách các bài báo
//   static const List<Widget> lstBaiBao = [
//     NongWidget(),
//     CongNgheWidget(),
//     DuLichWidget(),
//     GiaiTriWidget(),
//     GiaoDucWidget(),
//     KinhTeWidget(),
//     AmThucWidget(),
//     PhapLuatWidget(),
//     SucKhoeWidget(),
//     TheGioiWidget(),
//     TheGioiXeWidget(),
//     TheThaoWidget(),
//     ThietBiWidget(),
//     ThoiSuWidget(),
//     ThoiTrangWidget(),
//   ];

//   // Chỉ số của widget hiện tại
//   int selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     cmList = ReadDataCM().loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Hiển thị widget tương ứng với bài báo được chọn
//             Column(
//               children: [
//                 lstBaiBao[selectedIndex],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//     // Hiển thị widget tương ứng với selectedIndex
//   }
// }
