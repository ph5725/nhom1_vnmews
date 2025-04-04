// import 'package:flutter/material.dart';
// import 'package:nhom1_vnmews/data/model/nguontin_model.dart';
// import 'package:nhom1_vnmews/data/provider/nguontin_provider.dart';

// class ThongTinWidget extends StatefulWidget {
//   final int idNguonTin;  // Thêm idNguonTin để nhận dữ liệu từ trang trước

//   const ThongTinWidget({super.key, required this.idNguonTin});  // Constructor nhận idNguonTin

//   @override
//   State<ThongTinWidget> createState() => _ThongTinWidgetState();
// }

// class _ThongTinWidgetState extends State<ThongTinWidget> {
//   late Future<NguonTinModel> ntDetail;  // Future để lấy chi tiết nguồn tin

//   @override
//   void initState() {
//     super.initState();
//     ntDetail = ReadDataNT().loadDataById(widget.idNguonTin);  // Gọi API hoặc phương thức để lấy thông tin chi tiết theo id
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 50,
//         backgroundColor: const Color.fromRGBO(60, 107, 124, 0.514),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               "assets/logo/logochu.png",
//               height: 30,
//             ),
//             const SizedBox(height: 50),
//           ],
//         ),
//       ),
      
//       body: FutureBuilder<NguonTinModel>(
//         future: ntDetail,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Lỗi khi tải dữ liệu: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             NguonTinModel nt = snapshot.data!;

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView(
//                 children: [
//                   // Hình ảnh nguồn tin
//                   Center(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.asset(
//                         'assets/images/nguontin/${nt.img}', // Đảm bảo đường dẫn đúng
//                         width: 150,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Tên nguồn tin
//                   Text(
//                     nt.name ?? 'Tên nguồn tin chưa có',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),

//                   // Các thông tin chi tiết trong các Card
//                   _buildDetailCard('Loại hình', nt.loaiHinh),
//                   _buildDetailCard('Hình thức', nt.hinhThuc),
//                   _buildDetailCard('Trạng thái', nt.tinhTrang),
//                   _buildDetailCard('Chủ sở hữu', nt.chuSoHuu),
//                   _buildDetailCard('Thành lập', nt.thanhLap),
//                   _buildDetailCard('Giấy phép', nt.giayPhep),
//                   _buildDetailCard('Ngôn ngữ', nt.ngonNgu),
//                   _buildDetailCard('Trụ sở', nt.truSo),
//                   _buildDetailCard('Quốc gia', nt.quocGia),
//                   _buildDetailCard('Website', nt.webSite),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Không có dữ liệu.'));
//           }
//         },
//       ),
//     );
//   }

//   // Widget hiển thị thông tin chi tiết dưới dạng Card
//   Widget _buildDetailCard(String title, String? value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ListTile(
//           title: Text(
//             '$title: ',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: Color.fromARGB(255, 60, 107, 124),
//             ),
//           ),
//           subtitle: Text(
//             value ?? 'Chưa có dữ liệu',
//             style: const TextStyle(
//               fontSize: 14,
//             ),
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/nguontin_model.dart';
import 'package:nhom1_vnmews/data/provider/nguontin_provider.dart';
import 'package:url_launcher/url_launcher.dart';  // Đảm bảo thêm thư viện để mở URL

class ThongTinWidget extends StatefulWidget {
  final int idNguonTin;  // Thêm idNguonTin để nhận dữ liệu từ trang trước

  const ThongTinWidget({super.key, required this.idNguonTin});  // Constructor nhận idNguonTin

  @override
  State<ThongTinWidget> createState() => _ThongTinWidgetState();
}

class _ThongTinWidgetState extends State<ThongTinWidget> {
  late Future<NguonTinModel> ntDetail;  // Future để lấy chi tiết nguồn tin

  @override
  void initState() {
    super.initState();
    ntDetail = ReadDataNT().loadDataById(widget.idNguonTin);  // Gọi API hoặc phương thức để lấy thông tin chi tiết theo id
  }

  // Hàm mở liên kết URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở URL: $url';
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
            const SizedBox(height: 50),
          ],
        ),
      ),
      
      body: FutureBuilder<NguonTinModel>(
        future: ntDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi khi tải dữ liệu: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            NguonTinModel nt = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Hình ảnh nguồn tin
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/nguontin/${nt.img}', // Đảm bảo đường dẫn đúng
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tên nguồn tin
                  Text(
                    nt.name ?? 'Tên nguồn tin chưa có',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Các thông tin chi tiết trong các Card
                  _buildDetailCard('Loại hình', nt.loaiHinh),
                  _buildDetailCard('Hình thức', nt.hinhThuc),
                  _buildDetailCard('Trạng thái', nt.tinhTrang),
                  _buildDetailCard('Chủ sở hữu', nt.chuSoHuu),
                  _buildDetailCard('Thành lập', nt.thanhLap),
                  _buildDetailCard('Giấy phép', nt.giayPhep),
                  _buildDetailCard('Ngôn ngữ', nt.ngonNgu),
                  _buildDetailCard('Trụ sở', nt.truSo),
                  _buildDetailCard('Quốc gia', nt.quocGia),

                  // Thêm dòng mở URL
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Kiểm tra và mở URL nếu có
                      if (nt.webSite != null && nt.webSite!.isNotEmpty) {
                        _launchURL(nt.webSite!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Không có website"))
                        );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.link_sharp, color: Color.fromARGB(255, 60, 107, 124),),
                        SizedBox(width: 5),
                        Text(
                          'Đi đến website',
                          style: TextStyle(
                            color: Color.fromARGB(255, 60, 107, 124),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Không có dữ liệu.'));
          }
        },
      ),
    );
  }

  // Widget hiển thị thông tin chi tiết dưới dạng Card
  Widget _buildDetailCard(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          title: Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 60, 107, 124),
            ),
          ),
          subtitle: Text(
            value ?? 'Chưa có dữ liệu',
            style: const TextStyle(
              fontSize: 14,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
