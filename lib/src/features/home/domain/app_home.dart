class AppHome {
  String? token;
  String? fullname;
  String? avatar;
  String? email;
  String? phone;

  AppHome({
    this.token,
    this.fullname,
    this.avatar,
    this.email,
    this.phone,
  });
  factory AppHome.fromJson(Map<String, dynamic> json) {
    return AppHome(
      fullname: json['fullname'],
      avatar: json['avatar'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
