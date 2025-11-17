import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/widgets/app_confirm_dialog.dart';
import 'package:mpdam/core/widgets/app_search_bar.dart';
import 'package:mpdam/features/bank/domain/entities/search_bank_entity.dart';
import 'package:mpdam/features/bank/presentation/controllers/delete_bank_controller.dart';
import 'package:mpdam/features/bank/presentation/widgets/bank_body.dart';
import 'package:mpdam/features/bank/presentation/controllers/bank_controller.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';
import 'package:go_router/go_router.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final BankController controller = Get.find<BankController>();
  final DeleteBankController deleteController =
      Get.find<DeleteBankController>();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController(
    text: "",
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

    // Tampilkan loading pakai context
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final success = await deleteController.deleteBank(bankId);

    // Tutup loading
    if (Navigator.canPop(context)) Navigator.pop(context);

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
            onClear: () async {
              _searchController.clear();
              controller.isLoading.value = true;
              FocusScope.of(context).unfocus();
              await controller.fetchBanks(
                refresh: true,
                searchParam: BankSearchParam(
                  search: {}, // kosongkan search
                  pagination: PaggingParam(pageIndex: 1, pageSize: 10),
                ),
              );
              // controller.fetchBanks(refresh: true);
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
                // onEdit: (bank) => context.push('/edit-bank', extra: bank.oid),
                onEdit: (bank) async {
                  final result = await context.push(
                    '/edit-bank',
                    extra: bank.oid,
                  );
                  if (result == true) {
                    controller.fetchBanks(
                      refresh: true,
                    ); // fetch ulang data terbaru
                  }
                },
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
