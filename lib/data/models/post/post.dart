import 'package:minly_media_mobile/data/models/post/author.dart';

class Post {
  late String id;
  late String caption;
  late String mediaUrl;
  late String createdAt;
  late String type;
  late List<dynamic> likedBy;
  late Author author;

  Post.fromJson(dynamic data) {
    id = data['id'];
    caption = data['caption'];
    mediaUrl = data['mediaUrl'];
    createdAt = data['createdAt'];
    type = data['type'];
    likedBy = data['likedBy'];
    author = Author.fromJson(data['author']);
  }
}
