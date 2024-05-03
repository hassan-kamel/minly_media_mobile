part of 'post_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {
  final List<Post> posts = [];

  PostsInitial();
}

final class PostsFetching extends PostsState {}

final class PostFetchedSuccessfully extends PostsState {
  final List<Post> posts;

  const PostFetchedSuccessfully({required this.posts});
}

final class PostFetchError extends PostsState {
  final String message;
  const PostFetchError({required this.message});
}
