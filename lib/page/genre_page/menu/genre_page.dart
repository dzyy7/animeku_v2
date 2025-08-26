import 'package:animeku_v2/page/genre_page/controller/genre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenrePage extends StatelessWidget {
  final GenreController controller = Get.put(GenreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final genreListResponse = controller.genreListResponse;
        if (genreListResponse == null || genreListResponse.genres.isEmpty) {
          return const Center(child: Text('No genres available'));
        }

        return RefreshIndicator(
          onRefresh: controller.loadGenres,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3,
            ),
            itemCount: genreListResponse.genres.length,
            itemBuilder: (context, index) {
              final genre = genreListResponse.genres[index];
              
              return GestureDetector(
                onTap: () => controller.goToGenreAnime(genre.slug, genre.name),
                child: Card(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.8),
                          Colors.blue.withOpacity(0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        genre.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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