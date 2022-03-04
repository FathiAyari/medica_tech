class Admin {
   String email;
   String password;
   String username;

  Admin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    username = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['login'] = this.username;
    return data;
  }
}
