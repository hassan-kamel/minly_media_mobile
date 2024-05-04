import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/data/models/post/post.dart';
import 'package:minly_media_mobile/data/services/post.service.dart';

class PostRepository {
  final PostService postService;

  PostRepository({required this.postService});

  Future<List<Post>> getPosts(int pageNumber, int pageSize) async {
    final postsResponse = await postService.getPosts(pageNumber, pageSize);

    List<dynamic> posts = postsResponse['data'];
    debugPrint(posts.toString());
    return posts.map((post) => Post.fromJson(post)).toList();
  }
}
