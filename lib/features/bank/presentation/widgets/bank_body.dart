import 'package:flutter/material.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BankBody extends StatelessWidget {
  final List<Bank> banks;
  final bool isLoading;
  final bool isLoadMore;
  final int pageIndex;
  final int totalPages;
  final String errorMessage;
  final Future<void> Function()? onRefresh;
  final ScrollController? scrollController;
  final void Function(Bank bank)? onEdit;
  final void Function(Bank bank)? onDelete;

  const BankBody({
    super.key,
    required this.banks,
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
    // if (isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // if (errorMessage.isNotEmpty && banks.isEmpty) {
    //   return Center(child: Text(errorMessage));
    // }

    // if (banks.isEmpty) {
    //   return const Center(child: Text('No banks found'));
    // }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: banks.length + (isLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < banks.length) {
            final bank = banks[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Slidable(
                key: ValueKey(bank.oid), // pastikan setiap bank punya id unik
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) => onEdit?.call(bank),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (_) => onDelete?.call(bank),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  child: ListTile(
                    title: Text('${bank.bankCode} '),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bank Name: ${bank.bankName}'),
                        // Text('Phone: ${bank.shortName}'),
                        // Text('Created: ${bank.createdAt.toLocal()}'),
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
