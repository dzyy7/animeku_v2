import 'package:animeku_v2/bindings/app_pages.dart';
import 'package:animeku_v2/bindings/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Anime Stream',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1F1F1F),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
        cardColor: const Color(0xFF1F1F1F),
       
      ),
      initialBinding: InitialBinding(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}