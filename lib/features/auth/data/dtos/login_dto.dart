class LoginDto {
  final String email;
  final String password;

  LoginDto({
    required this.email,
    required this.password,
  });

  LoginDto copyWith({
    String? email,
    String? password,
  }) =>
      LoginDto(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory LoginDto.fromJson(Map<String, dynamic> json) => LoginDto(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
