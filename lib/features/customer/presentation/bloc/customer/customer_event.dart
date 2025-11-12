// lib/features/customer/presentation/bloc/customer/customer_event.dart
import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCustomers extends CustomerEvent {
  final bool refresh;
  FetchCustomers({this.refresh = false});
}

class LoadMoreCustomers extends CustomerEvent {}
