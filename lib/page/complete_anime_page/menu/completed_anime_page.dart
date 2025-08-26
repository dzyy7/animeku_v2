import 'package:animeku_v2/page/complete_anime_page/controller/complete_anime_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteAnimePage extends StatelessWidget {
  final CompleteAnimeController controller = Get.put(CompleteAnimeController());
  final ScrollController scrollController = ScrollController();

  CompleteAnimePage({Key? key}) : super(key: key) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Anime'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading && controller.allCompleteAnime.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: GridView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemCount: controller.allCompleteAnime.length +
                (controller.isLoadingMore ? 2 : 0),
            itemBuilder: (context, index) {
              if (index >= controller.allCompleteAnime.length) {
                return const Card(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final anime = controller.allCompleteAnime[index];

              return GestureDetector(
                onTap: () => controller.goToAnimeDetail(anime.slug),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(anime.poster),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  anime.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      anime.rating,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${anime.episodeCount} episodes',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  anime.lastReleaseDate,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
