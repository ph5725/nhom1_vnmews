import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/nguontin_model.dart';
import 'package:nhom1_vnmews/data/provider/nguontin_provider.dart';
import 'package:nhom1_vnmews/page/nguontin/nguontin_body.dart';

class NguonTinWidget extends StatefulWidget {
  const NguonTinWidget({super.key});

  @override
  State<NguonTinWidget> createState() =>
      _NguonTinWidgetState();
}

class _NguonTinWidgetState extends State<NguonTinWidget> {
  late Future<List<NguonTinModel>> ntList;

  @override
  void initState() {
    super.initState();
    ntList = ReadDataNT().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("NGUỒN TIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color.fromRGBO(42, 75, 87, 1),
                  fontSize: 20,
                ),
              ),
            ),

            FutureBuilder<List<NguonTinModel>>(
              future: ntList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Lỗi khi tải dữ liệu: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<NguonTinModel> lstNT = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true, // Cho phép GridView điều chỉnh kích thước
                    physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3/2,
                    ),
                    itemCount: lstNT.length,
                    itemBuilder: (context, index) {
                      return nguonTinBody(lstNT[index], context);
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Không có dữ liệu nguồn tin."),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
