import 'package:equatable/equatable.dart';
import 'package:mpdam/core/entity/pagging_param.dart';

class NewsSearchParam extends Equatable {
  final PaggingParam pagination;
  final Map<String, dynamic>? search;

  const NewsSearchParam({required this.pagination, this.search});

  @override
  List<Object?> get props => [pagination, search];
}
