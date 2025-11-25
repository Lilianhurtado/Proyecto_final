class Post {
  final int id;
  final String title;
  final String slug;
  final String summarry;
  final String featuredImage;
  final String publishedAt;
  final String authorName;
  

  Post({
    required this.id,
    required this.title,
    required this.slug,
    required this.summarry,
    required this.featuredImage,
    required this.publishedAt,
    required this.authorName,
   
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      summarry: json["summarry"],
      featuredImage: json["featured_image"],
      publishedAt: json["published_at"],
      authorName: json["author"]["name"],
      
    );
  }
}
