// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String oid;
  final String email;
  final String token;
  final String refreshToken;
  final bool? isActive;
  final String? createdBy;
  final String? updatedAt;

  const User({
    required this.oid,
    required this.email,
    required this.token,
    required this.refreshToken,
    required this.isActive,
    required this.createdBy,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      oid,
      email,
      token,
      refreshToken,
      isActive,
      createdBy,
      updatedAt,
    ];
  }
}
