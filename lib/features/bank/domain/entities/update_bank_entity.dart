import 'package:equatable/equatable.dart';

class UpdateBankEntity extends Equatable {
  final String oid;
  final String bankCode;
  final String bankName;
  // final String shortName;

  const UpdateBankEntity({
    required this.oid,
    required this.bankCode,
    required this.bankName,
    // required this.shortName,
  });
  @override
  List<Object?> get props => [bankCode, bankName];
}
