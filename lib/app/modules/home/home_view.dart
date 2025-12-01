import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final TextEditingController searchController = TextEditingController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchPosts();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Las ultimas noticias"),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔍 BUSCADOR
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Buscar post...",
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: controller.searchPosts,
                    onChanged: (value) {
                      if (value.isEmpty) controller.resetSearch();
                    },
                  ),
                ),
                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () =>
                      controller.searchPosts(searchController.text),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),

          // 📄 LISTA DE POSTS
          Expanded(
            child: Obx(() {
              if (controller.posts.isEmpty && controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.posts.isEmpty) {
                return const Center(child: Text("No se encontraron posts"));
              }

              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount:
                    controller.posts.length +
                    (controller.hasMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.posts.length) {
                    final post = controller.posts[index];

                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.POST_DETAIL, arguments: post.slug);
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🖼️ IMAGEN
                            Image.network(
                              post.featuredImage,
                              height: 500,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, st) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 80,
                                  color: Colors.blueAccent,
                                );
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                  Text(
                                    post.summary,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 18,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        post.authorName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return controller.hasMore.value
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox.shrink();
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
