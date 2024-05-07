import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/data/Repositories/post.repository.dart';
import 'package:minly_media_mobile/data/models/post/post.dart';
import 'package:minly_media_mobile/data/services/post.service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    // listeners
    on<PostsFetchEvent>(_fetchPosts);
    on<CreatePostEvent>(_handleCreatePost);
  }
  // handlers
  FutureOr<void> _fetchPosts(
      PostsFetchEvent event, Emitter<PostsState> emit) async {
    if (event.posts == null) {
      emit(PostsFetching());
    }

    try {
      final posts = await PostRepository(postService: PostService())
          .getPosts(event.pageNumber, event.pageSize);

      List<Post> castedPosts = [...posts];

      if (event.posts != null) {
        posts.addAll(event.posts!);
        List<Post> newPosts = [...event.posts!, ...castedPosts];
        debugPrint("new-pooooooooooooosts:  ${newPosts.length}");
        debugPrint("poooooooosts - length:  ${castedPosts.length}");
        emit(PostFetchedSuccessfully(
            posts: newPosts, endOfScrolling: castedPosts.isEmpty));
      } else {
        emit(PostFetchedSuccessfully(
            posts: castedPosts, endOfScrolling: castedPosts.isEmpty));
      }
    } catch (e) {
      emit(PostFetchError(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  FutureOr<void> _handleCreatePost(
      CreatePostEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetching());
    try {
      final post = await PostRepository(postService: PostService())
          .createPost(event.post);
      emit(PostCreatedSuccessfully(post: post));
    } catch (e) {
      emit(PostCreatedError(message: e.toString()));
      debugPrint("bloc$e");
    }
  }
}
