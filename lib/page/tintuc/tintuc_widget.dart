import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/chuyenmuc_model.dart';
import 'package:nhom1_vnmews/data/provider/chuyenmuc_provider.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/amthuc_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/congnghe_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/dulich_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/giaitri_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/giaoduc_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/kinhte_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/nong_.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/phapluat_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/suckhoe_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/thegioi_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/thegioixe_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/thethao_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/thietbi_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/thoisu_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/chuyenmuc/thoitrang_widget.dart';
import 'package:nhom1_vnmews/page/tintuc/topmenu_body.dart';

class TinTucWidget extends StatefulWidget {
  const TinTucWidget({super.key});

  @override
  State<TinTucWidget> createState() => _TinTucWidgetState();
}

class _TinTucWidgetState extends State<TinTucWidget> {
  late Future<List<ChuyenMucModel>> cmList;
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  // Danh sách các bài báo
  final List<Widget> lstBaiBao = const [
    NongWidget(),
    CongNgheWidget(),
    DuLichWidget(),
    GiaiTriWidget(),
    GiaoDucWidget(),
    KinhTeWidget(),
    AmThucWidget(),
    PhapLuatWidget(),
    SucKhoeWidget(),
    TheGioiWidget(),
    TheGioiXeWidget(),
    TheThaoWidget(),
    ThietBiWidget(),
    ThoiSuWidget(),
    ThoiTrangWidget(),
  ];

  // Chỉ số của widget hiện tại
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    cmList = ReadDataCM().loadData();
  }

  void _scrollToCenter(int index) {
    const double itemWidth = 100.0; // Chiều rộng mỗi nút (giả định)
    final double offset = index * itemWidth - (_scrollController.position.viewportDimension / 2) + (itemWidth / 2);
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Thanh menu phía trên
          Row(
            children: [
              IconButton(
                icon: Icon(selectedIndex == -1 ? Icons.home : Icons.home_outlined, color: const Color.fromARGB(255, 60, 107, 124)),
                onPressed: () {
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ).then((_) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        selectedIndex = -1;
                        _scrollToCenter(selectedIndex);
                      });
                    });
                  });
                },
              ),

              Expanded(
                child: SizedBox(
                  height: 50,
                  child: FutureBuilder<List<ChuyenMucModel>>(
                    future: cmList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Có lỗi khi tải dữ liệu'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Không có dữ liệu'));
                      } else {
                        List<ChuyenMucModel> lstCM = snapshot.data!;

                        return ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: lstCM.length,
                          itemBuilder: (context, index) {
                            return topMenuBody(
                              lstCM[index].name ?? '',
                              isSelected: selectedIndex == index, // Xác định nút nào được chọn
                              isLast: index == lstCM.length - 1,
                              onPressed: () {
                                setState(() {
                                  selectedIndex = index;
                                  debugPrint ("index: $index" );
                                  debugPrint ("select: $selectedIndex" );
                                });
                                _scrollToCenter(index);
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          // Hiển thị danh sách các bài báo
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _scrollToCenter(index);
              },
              itemCount: lstBaiBao.length,
              itemBuilder: (context, index) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: selectedIndex == -1
                      ? SingleChildScrollView(
                          key: ValueKey<int>(selectedIndex),
                          child: Column(children: lstBaiBao), // Hiển thị tất cả bài báo nếu chưa chọn
                        )
                      : SingleChildScrollView(
                          key: ValueKey<int>(selectedIndex),
                          child: Column(children: [lstBaiBao[index]]))     // Hiển thị bài báo được chọn
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
