class Post {
  final int id;
  final String title;
  final String slug;
  final String summary;
  final String featuredImage;
  final String publishedAt;
  final String authorName;

  Post({
    required this.id,
    required this.title,
    required this.slug,
    required this.summary,
    required this.featuredImage,
    required this.publishedAt,
    required this.authorName,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final img = json["featured_image"];

    // Convertir a URL absoluta si viene como /storage/...
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

    return Post(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      slug: json["slug"] ?? "",
      summary: json["summary"] ?? "",
      featuredImage: fullImage,
      publishedAt: json["published_at"] ?? "",
      authorName: json["author"]?["name"] ?? "Sin autor",
    );
  }
}
