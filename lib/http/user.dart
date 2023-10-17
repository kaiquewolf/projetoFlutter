class User {
  final bool success;
  final String token;
  final String name;
  final String message;
  final authorize_location;

  User(
      {required this.success,
      required this.token,
      required this.name,
      required this.message,
      this.authorize_location
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      success: json['sucess'],
      token: json['token'],
      name: json['name'],
      message: json['message'],
    );
  }
}
