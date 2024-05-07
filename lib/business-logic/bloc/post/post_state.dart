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

// Used for any loading state
final class PostsFetching extends PostsState {}

final class PostFetchedSuccessfully extends PostsState {
  final List<Post> posts;
  final bool endOfScrolling;

  const PostFetchedSuccessfully(
      {required this.posts, required this.endOfScrolling});
}

final class PostFetchError extends PostsState {
  final String message;
  const PostFetchError({required this.message});
}

final class PostCreatedSuccessfully extends PostsState {
  final Post post;
  const PostCreatedSuccessfully({required this.post});
}

final class PostCreatedError extends PostsState {
  final String message;
  const PostCreatedError({required this.message});
}
