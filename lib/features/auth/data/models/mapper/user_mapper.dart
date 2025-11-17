 
import 'package:mpdam/features/auth/data/models/user_model.dart';
import 'package:mpdam/features/auth/domain/entities/user.dart';

extension UserMapper on UserModel {
  User toDomain() => User(
        oid: oid,
        email: email,
        token: token,
        refreshToken: refreshToken,
        isActive: isActive,
        createdBy: createdBy,
        updatedAt: updatedAt,
      );
}
