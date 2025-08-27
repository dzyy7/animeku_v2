import 'package:animeku_v2/page/genre_page/controller/genre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenrePage extends StatelessWidget {
  final GenreController controller = Get.put(GenreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Genres',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading genres...',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        final genreListResponse = controller.genreListResponse;
        if (genreListResponse == null || genreListResponse.genres.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No genres available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pull down to refresh',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadGenres,
          color: Colors.blue[400],
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.8,
            ),
            itemCount: genreListResponse.genres.length,
            itemBuilder: (context, index) {
              final genre = genreListResponse.genres[index];
              final colors = _getGenreColors(index);

              return GestureDetector(
                onTap: () => controller.goToGenreAnime(genre.slug, genre.name),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () =>
                          controller.goToGenreAnime(genre.slug, genre.name),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Center(
                          child: Text(
                            genre.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

  List<Color> _getGenreColors(int index) {
    final colorSets = [
      [Colors.blue[400]!, Colors.blue[600]!],
      [Colors.purple[400]!, Colors.purple[600]!],
      [Colors.teal[400]!, Colors.teal[600]!],
      [Colors.orange[400]!, Colors.orange[600]!],
      [Colors.pink[400]!, Colors.pink[600]!],
      [Colors.indigo[400]!, Colors.indigo[600]!],
      [Colors.green[400]!, Colors.green[600]!],
      [Colors.red[400]!, Colors.red[600]!],
      [Colors.amber[400]!, Colors.amber[600]!],
      [Colors.cyan[400]!, Colors.cyan[600]!],
    ];

    return colorSets[index % colorSets.length];
  }
}
