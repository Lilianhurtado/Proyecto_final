import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/post_model.dart';
import '../../data/providers/post_provider.dart';

class HomeController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var hasMore = true.obs;

  var searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts({bool reset = false}) async {
    if (isLoading.value || (!hasMore.value && !reset)) return;

    try {
      isLoading.value = true;

      if (reset) {
        posts.clear();
        page.value = 1;
        hasMore.value = true;
      }

      final newPosts = await PostProvider.getPosts(
        page.value,
        query: searchQuery.value,
      );

      if (newPosts.isNotEmpty) {
        posts.addAll(newPosts);
        page.value++;

        if (newPosts.length < 10) {
          hasMore.value = false;
        }
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      print("Error en fetchPosts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchPosts(String query) {
    searchQuery.value = query;
    fetchPosts(reset: true);
  }

  void resetSearch() {
    if (searchQuery.value.isNotEmpty) {
      searchQuery.value = "";
      fetchPosts(reset: true);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    Get.offAllNamed("/login");
  }
}
