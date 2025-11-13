import 'package:equatable/equatable.dart';

class PaggingEntity extends Equatable {
  final int page;
  final int size;
  final int total;
  final int totalPage;

  const PaggingEntity({
    required this.page,
    required this.size,
    required this.total,
    required this.totalPage,
  });
  @override
  List<Object?> get props => [
        page,
        size,
        total,
        totalPage,
      ];
}
