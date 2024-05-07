import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/data/models/post/post.dart';
import 'package:minly_media_mobile/data/services/post.service.dart';

class PostRepository {
  final PostService postService;

  PostRepository({required this.postService});

  Future<dynamic> getPosts(int pageNumber, int pageSize) async {
    final postsResponse = await postService.getPosts(pageNumber, pageSize);

    // if error
    if (postsResponse?['message'] != null) {
      return {
        'message': postsResponse?['message'],
        'errors': postsResponse?['errors']
      };
    }

    List<dynamic> posts = postsResponse?['data'];
    debugPrint(posts.toString());
    return posts.map((post) => Post.fromJson(post)).toList();
  }

  Future<dynamic> createPost(FormData post) async {
    final response = await postService.createPost(post);

    debugPrint("response - repo   :$response");

    // if error
    if (response?['message'] != null) {
      return {'message': response?['message'], 'errors': response?['errors']};
    }

    return Post.fromJson(response);
  }
}
