import 'package:equatable/equatable.dart';

class CreateBankEntity extends Equatable {
  final String bankCode;
  final String bankName;
  // final String shortName;

  const CreateBankEntity({
    required this.bankCode,
    required this.bankName,
    // required this.shortName,
  });

  @override
  List<Object?> get props => [bankCode, bankName];
}
