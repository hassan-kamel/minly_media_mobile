import 'dart:async';

import 'package:bloc/bloc.dart';
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
  }
  // handlers
  FutureOr<void> _fetchPosts(
      PostsFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetching());
    try {
      debugPrint('hi');
      final posts = await PostRepository(postService: PostService())
          .getPosts(event.pageNumber, event.pageSize);

      emit(PostFetchedSuccessfully(posts: posts));

      debugPrint(posts.toString());
    } catch (e) {
      emit(PostFetchError(message: e.toString()));
      debugPrint(e.toString());
    }
  }
}
