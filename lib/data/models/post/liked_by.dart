class LikedBy {
  String? id;
  String? fullName;

  LikedBy({this.id, this.fullName});

  LikedBy.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
  }
}
