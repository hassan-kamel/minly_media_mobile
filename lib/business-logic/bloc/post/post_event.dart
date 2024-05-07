part of 'post_bloc.dart';

abstract class PostsEvent extends Equatable {}

class PostsFetchEvent extends PostsEvent {
  final int pageNumber;
  final int pageSize;

  final List<Post>? posts;

  PostsFetchEvent(
      {required this.pageNumber, required this.pageSize, this.posts});

  @override
  List<Object> get props => [pageNumber, pageSize];
}

class PostErrorEvent extends PostsEvent {
  final String message;

  PostErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class CreatePostEvent extends PostsEvent {
  final FormData post;

  CreatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}
