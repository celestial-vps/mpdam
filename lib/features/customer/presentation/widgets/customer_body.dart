import 'package:flutter/material.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomerBody extends StatelessWidget {
  final List<Customer> customers;
  final bool isLoading;
  final bool isLoadMore;
  final int pageIndex;
  final int totalPages;
  final String errorMessage;
  final Future<void> Function()? onRefresh;
  final ScrollController? scrollController;
  final void Function(Customer customer)? onEdit;
  final void Function(Customer customer)? onDelete;

  const CustomerBody({
    super.key,
    required this.customers,
    required this.isLoading,
    required this.isLoadMore,
    required this.pageIndex,
    required this.totalPages,
    required this.errorMessage,
    this.onRefresh,
    this.scrollController,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // if (isLoading && customers.isEmpty) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // if ((isLoading || isSearching) && customers.isEmpty) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    if (errorMessage.isNotEmpty && customers.isEmpty) {
      return Center(child: Text(errorMessage));
    }

    if (customers.isEmpty) {
      return const Center(child: Text('No customers found'));
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: customers.length + (isLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < customers.length) {
            final customer = customers[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Slidable(
                key: ValueKey(
                  customer.oid,
                ), // pastikan setiap customer punya id unik
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) => onEdit?.call(customer),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (_) => onDelete?.call(customer),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  child: ListTile(
                    title: Text(
                      '${customer.firstName} ${customer.middleName} ${customer.lastName}',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${customer.email ?? '-'}'),
                        Text('Phone: ${customer.phoneNumber ?? '-'}'),
                        Text('Address: ${customer.address ?? '-'}'),
                        Text('Created: ${customer.createdAt.toLocal()}'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
