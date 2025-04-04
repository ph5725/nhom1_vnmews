class UserModel {
  String? fullname;
  String? email;
  String? pass;
  String? phone;

  //constructor
  UserModel({this.fullname, this.email, this.pass, this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    pass = json['pass'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["fullname"] = fullname;
    data["email"] = email;
    data["pass"] = pass;
    data["phone"] = phone;

    return data;
  }
}