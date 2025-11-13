
import 'package:mpdam/features/bank/data/models/bank_model.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';

extension BankMapper on List<BankModel> {
  List<Bank> toDomain() => List.from(
        map(
          (e) => e.toDomain(),
        ),
      );
}

extension BankModelMapper on BankModel {
  Bank toDomain() => Bank(
        oid: oid,
        bankCode: bankCode,
        bankName: bankName,
        // shortName: shortName,        
        createdAt: createdAt,
        updatedAt: updatedAt,
        
      );
}
