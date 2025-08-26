import 'package:animeku_v2/page/schedule/controller/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchedulePage extends StatelessWidget {
  final ScheduleController controller = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Schedule'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final scheduleData = controller.scheduleData;
        if (scheduleData == null || scheduleData.schedules.isEmpty) {
          return const Center(child: Text('No schedule data available'));
        }

        return RefreshIndicator(
          onRefresh: controller.loadSchedule,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scheduleData.schedules.length,
            itemBuilder: (context, index) {
              final daySchedule = scheduleData.schedules[index];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        daySchedule.day,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    if (daySchedule.animeList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'No anime scheduled for this day',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: daySchedule.animeList.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, animeIndex) {
                          final anime = daySchedule.animeList[animeIndex];
                          
                          return ListTile(
                            title: Text(
                              anime.animeName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                            onTap: () => controller.goToAnimeDetail(anime.slug),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}