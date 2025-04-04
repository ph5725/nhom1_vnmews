import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/conf/const.dart';
import 'package:nhom1_vnmews/data/model/tintuc_model.dart';
import 'package:nhom1_vnmews/data/model/tintuc_viewmodel.dart';
import 'package:nhom1_vnmews/page/tincuaban/tincuaban_body.dart';
import 'package:provider/provider.dart';

class TinCuaBanWidget extends StatefulWidget {
  const TinCuaBanWidget({super.key});

  @override
  State<TinCuaBanWidget> createState() => _TinCuaBanWidgetState();
}

class _TinCuaBanWidgetState extends State<TinCuaBanWidget> {
  int _selectedIndex = 0;
  var lstTinTucStr = "";
  List<TinTucModel> lstItem = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        const Text("Tin Của Bạn", style: titleStyle),
        Container(
          height: 2,
          color: const Color.fromARGB(255, 60, 107, 124),
          margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 0),
        ),
        Expanded(
          child: Consumer<TinTucVM>(
            builder: (context, value, child) => Scaffold(
              body: ListView.builder(
                itemCount: value.lst.length,
                itemBuilder: (context, index) {
                  _selectedIndex = index;
                  return tinCuaBanBody(value.lst[index], context);
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Consumer<TinTucVM>(
              builder: (context, value, child) => ElevatedButton.icon(
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                label: const Text(''),
                onPressed: () {
                  if (value.lst.isNotEmpty) {
                    value.allDel();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Đã xóa toàn bộ danh sách!"),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Cập nhật giao diện
                    setState(() {});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Danh sách hiện tại rỗng!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor:
                      const Color.fromARGB(255, 217, 83, 79),
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 17,
                    right: 10,
                  ),
                  shape: const CircleBorder(),
                  elevation: 5, // Hiệu ứng bóng
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
