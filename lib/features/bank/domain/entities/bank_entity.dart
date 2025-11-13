import 'package:equatable/equatable.dart';
import 'package:mpdam/core/entity/pagging_entity.dart';

class BankEntity extends Equatable {
  final PaggingEntity pagination;
  final List<Bank> data;

  const BankEntity({required this.pagination, required this.data});

  @override
  List<Object?> get props => [pagination, data];
}

class Bank extends Equatable {
  final String oid;
  final String bankCode;
  final String bankName;
  // final String shortName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Bank({
    required this.oid,
    required this.bankCode,
    required this.bankName,
    // required this.shortName,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  List<Object?> get props => [
    oid,
    bankCode,
    bankName,
    // shortName,
    createdAt,
    updatedAt, // bisa null
  ]; 
}
