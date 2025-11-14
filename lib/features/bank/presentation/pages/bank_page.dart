import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/widgets/app_confirm_dialog.dart';
import 'package:mpdam/core/widgets/app_search_bar.dart';
import 'package:mpdam/features/bank/domain/entities/search_bank_entity.dart';
import 'package:mpdam/features/bank/presentation/controllers/delete-bank_controller.dart';
import 'package:mpdam/features/bank/presentation/widgets/bank_body.dart';
import 'package:mpdam/features/bank/presentation/widgets/search_bank_bar.dart';
import 'package:mpdam/features/bank/presentation/controllers/bank_controller.dart';
import 'package:mpdam/service_locator.dart';
import 'package:go_router/go_router.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final BankController controller = Get.put(sl<BankController>());
  final DeleteBankController deleteController = Get.put(
    sl<DeleteBankController>(),
  );

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController(
    text: "Bank Negara Indonesia",
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !controller.isLoadMore.value &&
        controller.pageIndex <= controller.totalPages) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete(String bankId) async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: "Delete Bank",
      message: "Are you sure you want to delete this bank?",
    );

    if (!confirmed) return;

    final success = await deleteController.deleteBank(bankId);

    if (success) {
      controller.fetchBanks(refresh: true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bank deleted successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete bank"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banks')),
      body: Column(
        children: [
          AppSearchBar(
            controller: _searchController,
            onChanged: (query) {
              controller.fetchBanks(
                refresh: true,
                searchParam: BankSearchParam(
                  search: {'search': query},
                  pagination: PaggingParam(pageIndex: 1, pageSize: 10),
                ),
              );
            },
            onClear: () {
              _searchController.clear();
              controller.fetchBanks(refresh: true);
              FocusScope.of(context).unfocus();
            },
          ),
          Expanded(
            child: Obx(
              () => BankBody(
                banks: controller.banks,
                isLoading: controller.isLoading.value,
                isLoadMore: controller.isLoadMore.value,
                pageIndex: controller.pageIndex,
                totalPages: controller.totalPages,
                errorMessage: controller.errorMessage.value,
                onRefresh: () => controller.fetchBanks(refresh: true),
                scrollController: _scrollController,
                onEdit: (bank) => context.push('/edit-bank', extra: bank.oid),
                onDelete: (bank) => _confirmDelete(bank.oid),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await context.push('/add-bank');
          if (result == true) controller.fetchBanks(refresh: true);
        },
      ),
    );
  }
}
