import 'package:minly_media_mobile/data/models/post/author.dart';
import 'package:minly_media_mobile/data/models/post/liked_by.dart';

class Post {
  late String id;
  late String caption;
  late String mediaUrl;
  late DateTime createdAt;
  late String type;
  late List<LikedBy> likedBy;
  late Author author;

  Post.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    caption = data['caption'];
    mediaUrl = data['mediaUrl'];
    createdAt = DateTime.parse(data['createdAt']);
    type = data['type'];
    likedBy = data['likedBy'];
    author = data['author'];
  }
}
