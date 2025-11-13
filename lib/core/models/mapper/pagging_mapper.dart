
import 'package:mpdam/core/entity/pagging_entity.dart';
import 'package:mpdam/core/models/pagging_model.dart';

extension PaggingMapper on PaggingModel {
  PaggingEntity toDomain() => PaggingEntity(
        page: page,
        size: size,
        total: total,
        totalPage: totalPage,
      );
}
