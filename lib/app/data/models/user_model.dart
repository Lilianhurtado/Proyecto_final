class User {
  final int id;
  final String name;
  final String email;
  final String? descripcion;
  final String? urlFacebook;
  final String? urlInstagram;
  final String? urlYoutube;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.descripcion,
    this.urlFacebook,
    this.urlInstagram,
    this.urlYoutube,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      descripcion : json["descripcion"],
      urlFacebook : json["urlfacebook"],
      urlInstagram : json["urlinstagram"],
      urlYoutube : json["urlyoutube"],
      role : json["role"],
      createdAt : json["created_at"],
      updatedAt : json["updated_at"],
    );
  }
}
