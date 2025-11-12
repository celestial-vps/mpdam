import 'package:equatable/equatable.dart';

class PaggingParam extends Equatable {
  final int? pageIndex;
  final int? pageSize;
  final Map<String, dynamic>? search;

  const PaggingParam({
    required this.pageIndex,
    required this.pageSize,
    this.search,
  });

  PaggingParam copyWith({
    int? pageIndex,
    int? pageSize,
    Map<String, dynamic>? search,
  }) {
    return PaggingParam(
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [pageIndex, pageSize, search];
}
