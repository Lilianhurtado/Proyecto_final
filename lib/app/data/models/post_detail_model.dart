class PostDetail {
  final int id;
  final String title;
  final String slug;
  final String content;
  final String featuredImage;
  final String publishedAt;
  final String authorName;
  final List<String> categories;
  final List<String> tags;

  PostDetail({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.featuredImage,
    required this.publishedAt,
    required this.authorName,
    required this.categories,
    required this.tags,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    final img = json["featured_image"];

    String fullImage = "";
    if (img != null && img.toString().isNotEmpty) {
      if (img.toString().startsWith("http")) {
        fullImage = img;
      } else {
        fullImage = "http://localhost:8000/$img";
      }
    } else {
      fullImage = "https://via.placeholder.com/600x400";
    }

    return PostDetail(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      slug: json["slug"] ?? "",
      content: json["content"] ?? "",
      featuredImage: fullImage,
      publishedAt: json["published_at"] ?? "",
      authorName: json["author"]?["name"] ?? "Sin autor",

      categories: (json["categories"] as List? ?? [])
          .map((c) => c["name"].toString())
          .toList(),

      tags: (json["tags"] as List? ?? [])
          .map((t) => t["name"].toString())
          .toList(),
    );
  }
}
