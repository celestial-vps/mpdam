class LoginResponse {
  final String token;
  final String refreshToken;  // tambahan
  final String email;
  final String role;
  final bool isActive;

  LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.email,
    required this.role,
    required this.isActive,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponse(
      token: data['token'],
      refreshToken: data['refreshToken'] ?? '', // bisa kosong kalau ga ada
      email: data['email'],
      role: data['userRole']['roleName'],
      isActive: data['isActive'],
    );
  }
}
