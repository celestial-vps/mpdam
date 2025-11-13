import 'package:mpdam/core/models/mapper/pagging_mapper.dart';
import 'package:mpdam/features/bank/data/models/list_bank_model.dart';
import 'package:mpdam/features/bank/data/models/mapper/bank_mapper.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';

extension ListBankMapper on ListBankModel {
  BankEntity toDomain() =>
      BankEntity(pagination: pagination.toDomain(), data: data.toDomain());
}
