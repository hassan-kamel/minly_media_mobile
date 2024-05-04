class User {
  String? id;
  String? fullName;
  String? email;
  String? password;

  User({this.id, this.fullName, this.email, this.password});

  User.fromJson(dynamic data) {
    id = data['id'];
    fullName = data['fullName'];
    email = data['email'];
  }

  Map<String, dynamic> toJsonForSignup() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  Map<String, dynamic> toJsonForLogin() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
