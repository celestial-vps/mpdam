class RegisterDto {
  final String email;
  final String password;

  RegisterDto({required this.email, required this.password});

  factory RegisterDto.fromJson(Map<String, dynamic> json) => RegisterDto(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
