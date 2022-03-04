class UserData {
   int age;
   String lastname;
   String login;
   String name;
   String password;

  UserData.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    lastname = json['lastname'];
    login = json['login'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['lastname'] = this.lastname;
    data['login'] = this.login;
    data['name'] = this.name;
    data['password'] = this.password;
    return data;
  }
}
