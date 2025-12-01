import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'post_detail_controller.dart';

class PostDetailView extends GetView<PostDetailController> {
  final String slug;

  const PostDetailView({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    controller.fetchPostDetail(slug);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Post"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final post = controller.post.value;

        if (post == null) {
          return const Center(child: Text("No se pudo cargar el post"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                post.featuredImage,
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.blueAccent,
                  );
                },
              ),

              const SizedBox(height: 16),

              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "✍️ ${post.authorName} - 📅 ${post.publishedAt}",
                style: const TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                children: post.categories
                    .map(
                      (c) => Chip(
                        label: Text(c),
                        backgroundColor: Colors.blue[50],
                        labelStyle: const TextStyle(color: Colors.blueAccent),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 16),

              Text(
                post.content,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),

              const SizedBox(height: 24),

              if (post.tags.isNotEmpty) ...[
                const Text(
                  "Etiquetas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  children: post.tags
                      .map(
                        (t) => Chip(
                          label: Text(t),
                          backgroundColor: Colors.green[50],
                          labelStyle: const TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
