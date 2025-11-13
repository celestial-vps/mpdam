import 'package:equatable/equatable.dart';
import 'package:mpdam/core/entity/pagging_param.dart';

class BankSearchParam extends Equatable {
  final PaggingParam pagination;
  final Map<String, dynamic>?
  search;

  const BankSearchParam({required this.pagination, this.search});

  @override
  List<Object?> get props => [pagination, search];
}
