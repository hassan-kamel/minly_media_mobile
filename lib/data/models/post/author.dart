class Author {
  String? id;
  String? fullName;

  Author({this.id, this.fullName});

  Author.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
  }
}
