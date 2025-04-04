import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/conf/const.dart';
import 'package:nhom1_vnmews/data/model/tintuc_model.dart';
import 'package:nhom1_vnmews/data/provider/tintuc_provider.dart';
import 'package:nhom1_vnmews/page/tintuc/tintuc_body.dart';

class GiaiTriWidget extends StatefulWidget {
  const GiaiTriWidget({super.key});

  @override
  State<GiaiTriWidget> createState() => _GiaiTriWidgetState();
}

class _GiaiTriWidgetState extends State<GiaiTriWidget> {
  late Future<List<TinTucModel>> ttList;

  @override
  void initState() {
    super.initState();
    ttList = RDGiaiTri().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(  "Giải Trí", style: titleStyle),

        Container(
          height: 2,
          color: const Color.fromARGB(255, 60, 107, 124),
          margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 0),
        ),

        FutureBuilder<List<TinTucModel>>(
          future: ttList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Lỗi khi tải dữ liệu: ${snapshot.error}"),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<TinTucModel> lstTT = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true, // Cho phép ListView điều chỉnh kích thước
                physics:
                    const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn
                itemCount: lstTT.length,
                itemBuilder: (context, index) {
                  return tinTucBody(lstTT[index], context);
                },
              );
            } else {
              return const Center(
                child: Text("Không có dữ liệu chuyên mục."),
              );
            }
          },
        )
      ],
    );
  }
}
