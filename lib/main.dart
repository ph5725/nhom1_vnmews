// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:nhom1_vnmews/data/model/tintuc_viewmodel.dart';
import 'package:nhom1_vnmews/data/provider/auth_provider.dart';
import 'package:nhom1_vnmews/page/trangchu/trangchu_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TinTucVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const TrangChuWidget(),
      ),
    );
  }
}
