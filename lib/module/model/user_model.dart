class UserModel {
  int? id;
  String? name;
  String? company;
  String? username;
  String? email;
  String? address;
  String? zip;
  String? state;
  String? country;
  String? phone;
  String? photo;

  UserModel(
      {this.id,
        this.name,
        this.company,
        this.username,
        this.email,
        this.address,
        this.zip,
        this.state,
        this.country,
        this.phone,
        this.photo});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    company = json['company'];
    username = json['username'];
    email = json['email'];
    address = json['address'];
    zip = json['zip'];
    state = json['state'];
    country = json['country'];
    phone = json['phone'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company'] = this.company;
    data['username'] = this.username;
    data['email'] = this.email;
    data['address'] = this.address;
    data['zip'] = this.zip;
    data['state'] = this.state;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    return data;
  }
}