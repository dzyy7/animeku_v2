import 'package:animeku_v2/page/search_page/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeSearchController>(() => AnimeSearchController());
  }
}