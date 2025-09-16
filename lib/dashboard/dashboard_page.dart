import 'package:animeku_v2/page/anime_page/menu/home_page.dart';
import 'package:animeku_v2/page/complete_anime_page/menu/completed_anime_page.dart';
import 'package:animeku_v2/page/genre_page/menu/genre_page.dart';
import 'package:animeku_v2/page/schedule/menu/schedule_page.dart';
import 'package:animeku_v2/page/search_page/menu/search_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  final List<Widget> pages = [
    HomePage(),
    SchedulePage(),
    CompleteAnimePage(),
    GenrePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex,
            children: pages,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex,
            onTap: controller.changePage,
            backgroundColor: const Color(0xFF1F1F1F),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Complete',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Genre',
              ),
            ],
          )),
    );
  }
}
