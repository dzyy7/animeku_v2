// // lib/page/search_page/menu/search_page.dart

// import 'package:animeku_v2/page/search_page/controller/search_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class SearchPage extends StatelessWidget {
//   final AnimeSearchController controller = Get.put(AnimeSearchController());
//   final TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0F0F0F),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1A1A1A),
//         elevation: 0,
//         title: const Text(
//           'Search Anime',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           _buildSearchBar(),

//           // Character Filter (only show when not searching)
//           Obx(() => !controller.isSearching
//               ? _buildCharacterFilter()
//               : const SizedBox()),

//           // Content
//           Expanded(
//             child: Obx(() => _buildContent()),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFF2A2A2A),
//             const Color(0xFF252525),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.1),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: searchController,
//         onChanged: controller.onSearchChanged,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: 'Search anime...',
//           hintStyle: TextStyle(color: Colors.grey[400]),
//           prefixIcon: Icon(
//             Icons.search,
//             color: Colors.grey[400],
//           ),
//           suffixIcon: Obx(() => controller.searchKeyword.isNotEmpty
//               ? IconButton(
//                   icon: Icon(Icons.clear, color: Colors.grey[400]),
//                   onPressed: () {
//                     searchController.clear();
//                     controller.clearSearch();
//                   },
//                 )
//               : const SizedBox()),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCharacterFilter() {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Obx(() => ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: controller.availableCharacters.length,
//             itemBuilder: (context, index) {
//               final character = controller.availableCharacters[index];
//               final isSelected = character == controller.selectedCharacter;

//               return Container(
//                 margin: const EdgeInsets.only(right: 8),
//                 child: FilterChip(
//                   label: Text(
//                     character,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.grey[400],
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   selected: isSelected,
//                   onSelected: (_) => controller.selectCharacter(character),
//                   selectedColor: const Color(0xFF4A90E2),
//                   backgroundColor: const Color(0xFF2A2A2A),
//                   checkmarkColor: Colors.white,
//                   side: BorderSide(
//                     color: isSelected
//                         ? const Color(0xFF4A90E2)
//                         : Colors.white.withOpacity(0.1),
//                     width: 1,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               );
//             },
//           )),
//     );
//   }

//   Widget _buildContent() {
//     if (controller.isSearching) {
//       return _buildSearchResults();
//     } else {
//       return _buildUnlimitedAnimeList();
//     }
//   }

//   Widget _buildSearchResults() {
//     if (controller.isLoadingSearch) {
//       return _buildLoadingWidget('Searching...');
//     }

//     if (!controller.hasSearchResults) {
//       return _buildEmptyWidget(
//         'No results found',
//         'Try different keywords',
//         Icons.search_off_rounded,
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: controller.refresh,
//       child: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.7,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//         ),
//         itemCount: controller.searchResults.length,
//         itemBuilder: (context, index) {
//           final anime = controller.searchResults[index];
//           return _buildSearchResultCard(anime);
//         },
//       ),
//     );
//   }

//   Widget _buildUnlimitedAnimeList() {
//     if (controller.isLoadingUnlimited) {
//       return _buildLoadingWidget('Loading anime list...');
//     }

//     if (controller.filteredUnlimitedAnime.isEmpty) {
//       return _buildEmptyWidget(
//         'No anime found',
//         'Try selecting different character',
//         Icons.movie_filter_rounded,
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: controller.refresh,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: controller.filteredUnlimitedAnime.length,
//         itemBuilder: (context, index) {
//           final anime = controller.filteredUnlimitedAnime[index];
//           return _buildUnlimitedAnimeCard(anime);
//         },
//       ),
//     );
//   }

//   Widget _buildSearchResultCard(searchResult) {
//     return GestureDetector(
//       onTap: () => controller.goToAnimeDetail(searchResult.slug),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               const Color(0xFF2A2A2A),
//               const Color(0xFF1A1A1A),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.1),
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Poster
//             Expanded(
//               flex: 3,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//                 child: Stack(
//                   children: [
//                     CachedNetworkImage(
//                       imageUrl: searchResult.poster,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                       placeholder: (context, url) => Container(
//                         color: Colors.grey[800],
//                         child: const Center(
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                           ),
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => Container(
//                         color: Colors.grey[800],
//                         child: const Icon(
//                           Icons.error_outline_rounded,
//                           color: Colors.grey,
//                           size: 40,
//                         ),
//                       ),
//                     ),
//                     // Rating badge
//                     if (searchResult.rating.isNotEmpty)
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.star,
//                                 size: 12,
//                                 color: Colors.amber,
//                               ),
//                               const SizedBox(width: 2),
//                               Text(
//                                 searchResult.rating,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     // Status badge
//                     Positioned(
//                       top: 8,
//                       left: 8,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: searchResult.status.toLowerCase() == 'ongoing'
//                               ? Colors.green.withOpacity(0.9)
//                               : Colors.blue.withOpacity(0.9),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           searchResult.status,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Info
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title
//                     Expanded(
//                       child: Text(
//                         searchResult.title,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(height: 8),

//                     // Genres
//                     if (searchResult.genres.isNotEmpty)
//                       Wrap(
//                         spacing: 4,
//                         runSpacing: 4,
//                         children:
//                             searchResult.genres.take(2).map<Widget>((genre) {
//                           return Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 6,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF4A90E2).withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(6),
//                               border: Border.all(
//                                 color: const Color(0xFF4A90E2).withOpacity(0.5),
//                                 width: 0.5,
//                               ),
//                             ),
//                             child: Text(
//                               genre.name,
//                               style: const TextStyle(
//                                 color: Color(0xFF4A90E2),
//                                 fontSize: 8,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUnlimitedAnimeCard(unlimitedAnime) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFF2A2A2A),
//             const Color(0xFF252525),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.1),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 12,
//         ),
//         leading: Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
//             ),
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF4A90E2).withOpacity(0.4),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.movie_rounded,
//             color: Colors.white,
//             size: 24,
//           ),
//         ),
//         title: Text(
//           unlimitedAnime.title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//           ),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         subtitle: Text(
//           'ID: ${unlimitedAnime.animeId}',
//           style: TextStyle(
//             color: Colors.grey[400],
//             fontSize: 12,
//           ),
//         ),
//         trailing: Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: const Color(0xFF4A90E2).withOpacity(0.2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Icon(
//             Icons.arrow_forward_ios_rounded,
//             color: Color(0xFF4A90E2),
//             size: 16,
//           ),
//         ),
//         onTap: () {
//           // Extract slug from href (/anime/slug -> slug)
//           final slug = unlimitedAnime.href.replaceFirst('/anime/', '');
//           controller.goToAnimeDetail(slug);
//         },
//       ),
//     );
//   }

//   Widget _buildLoadingWidget(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
//               ),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.all(16),
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 strokeWidth: 3,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyWidget(String title, String subtitle, IconData icon) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.grey.withOpacity(0.3),
//                   Colors.grey.withOpacity(0.1),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: Icon(
//               icon,
//               size: 40,
//               color: Colors.grey[400],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             subtitle,
//             style: TextStyle(
//               color: Colors.grey[400],
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
