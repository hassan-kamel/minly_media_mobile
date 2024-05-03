part of 'post_bloc.dart';

abstract class PostsEvent extends Equatable {}

class PostsFetchEvent extends PostsEvent {
  final int pageNumber;
  final int pageSize;

  PostsFetchEvent({required this.pageNumber, required this.pageSize});

  @override
  List<Object> get props => [pageNumber, pageSize];
}

class PostErrorEvent extends PostsEvent {
  final String message;

  PostErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}
