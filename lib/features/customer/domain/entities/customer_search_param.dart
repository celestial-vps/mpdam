import 'package:equatable/equatable.dart';
import 'package:mpdam/core/entity/pagging_param.dart';

class CustomerSearchParam extends Equatable {
  final PaggingParam pagging;
  final Map<String, dynamic>?
  search;

  const CustomerSearchParam({required this.pagging, this.search});

  @override
  List<Object?> get props => [pagging, search];
}
