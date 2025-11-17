 
import 'package:mpdam/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.oid,
    required super.email,
    required super.token,
    required super.refreshToken,
    required super.isActive,
    required super.createdBy,
    required super.updatedAt,
  }) : super();

  factory UserModel.fromJson(Map<String, dynamic> dataJson) {
    Map<String, dynamic> data = dataJson["data"];
    return UserModel(
      oid: data["oid"],
      email: data["email"],
      token: data["token"],
      refreshToken: data["refreshToken"],
      isActive: data["isActive"],
      createdBy: data["createdBy"],
      updatedAt: data["updatedAt"],
    );
  }

    Map<String,dynamic> toJson(){
    return {
      "oid":oid,
      "email":email,
      "token":token,
      "refreshToken":refreshToken,
      "isActive":isActive,
      "createdBy":createdBy,
      "updatedAt":updatedAt,
    };
  }
}
