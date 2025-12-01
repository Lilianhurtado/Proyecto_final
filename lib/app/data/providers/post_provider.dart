import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';
import '../models/post_detail_model.dart';

import '../../../utils/constants.dart';

class PostProvider {

  static Future<List<Post>> getPosts(
    int page, {
    int perPage = 10,
    String query = "",
  }) async {
    try {
      final presfs = await SharedPreferences.getInstance();
      final token = presfs.getString("token");

      final url =
          "${AppConstants.baseUrl}/posts?page=$page&per_page=$perPage${query.isNotEmpty ? "&q=$query" : ""}";

      print("URL request: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List data = jsonData["data"];
        return data.map((e) => Post.fromJson(e)).toList();
      } else {
        print("Error al obtener posts: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception en getPosts: $e");
      return [];
    }
  }

  //Metodo Registro
  static Future<PostDetail?> getPostDetail(String slug) async {
    try {
      final presfs = await SharedPreferences.getInstance();
      final token = presfs.getString("token");

      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/posts/$slug"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PostDetail.fromJson(jsonData);
      } else {
        print("Error al obtener detalle: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception en getPostDetail: $e");
      return null;
    }
  }

}
