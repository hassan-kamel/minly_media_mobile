import 'package:minly_media_mobile/data/models/post/post.dart';
import 'package:minly_media_mobile/data/services/post.service.dart';

class PostRepository {
  final PostService postService;

  PostRepository({required this.postService});

  Future<List<Post>> getPosts(int pageNumber, int pageSize) async {
    final posts = await postService.getPosts(pageNumber, pageSize);
    return posts.map((post) => Post.fromJson(post)).toList();
  }
}
