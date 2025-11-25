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
    return PostDetail(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      content: json["content"],
      featuredImage: json["featured_image"],
      publishedAt: json["published_at"],
      authorName: json["author"]["name"],
      categories: (json["categories"] as List).map((c)=>c["name"].toString()).toList(),
      tags: (json["tags"] as List).map((t)=>t["name"].toString()).toList(),
    );
  }
}
