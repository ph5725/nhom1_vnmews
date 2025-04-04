import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/tintuc_model.dart';
import 'package:nhom1_vnmews/data/model/tintuc_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Widget tinTucBody(TinTucModel item, BuildContext context) {
  // Hàm xử lý mở URL
  void _openUrl(String? url, BuildContext context) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đường link không hợp lệ')),
      );
      return;
    }

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Mở bằng trình duyệt ngoài
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể mở đường link')),
      );
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        onTap: () => _openUrl(item.urlNoiDung, context),
        splashColor: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Text(
                item.tieuDe ?? 'Không có tiêu đề',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Nội dung: Hình ảnh + mô tả
              Row(
                children: [
                  if (item.urlImage != null)
                    Image.network(
                      item.urlImage!,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.moTa ?? 'Không có mô tả',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 59, 59, 59),
                        fontSize: 13,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Thông tin ngày đăng và nguồn
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.ngayDang ?? '',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 121, 121, 121),
                      fontSize: 9,
                    ),
                  ),
                  const Spacer(),
                  if (item.nguon != null)
                    Image.network(
                      item.nguon!,
                      width: 40,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  Consumer<TinTucVM>(
                    builder: (context, value, child) {
                      bool isFavorite = value.lst.contains(
                          item); // Kiểm tra xem bài viết đã được yêu thích chưa

                      return IconButton(
                        icon: Icon(
                          isFavorite? Icons.favorite : Icons.favorite_border, // Thay đổi biểu tượng
                          color: const Color.fromARGB(255, 60, 107, 124), // Màu sắc khác nhau
                        ),
                        onPressed: () {
                          if (!isFavorite) {
                            value.add(
                                item); // Thêm bài viết vào danh sách yêu thích

                            // Hiển thị thông báo
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Đã thêm "${item.tieuDe}" vào mục yêu thích!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          } 
                          else {
                            value.del(value.lst.indexOf( item)); // Xóa bài viết khỏi danh sách yêu thích

                            // Hiển thị thông báo
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Đã xóa "${item.tieuDe}" khỏi mục yêu thích!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Đường phân cách
      Container(
        height: 0.7,
        color: const Color.fromARGB(198, 189, 189, 189),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      ),
    ],
  );
}
