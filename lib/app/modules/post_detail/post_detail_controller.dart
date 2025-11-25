import 'package:get/get.dart';
import '../../data/models/post_detail_model.dart';
import '../../data/providers/post_provider.dart';

class PostDetailController extends GetxController {
  var post = Rxn<PostDetail>();
  var isLoading = false.obs;

  Future<void> fetchPostDetail(String slug) async {
    try {
      isLoading.value = true;
      final response = await PostProvider.getPostDetail(slug);
      if (response != null) {
        post.value = response;
      } else {
        print("No se pudo cargar el detalle del post");
      }
    } catch (e) {
      print("Error en fetchPostDetail: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
