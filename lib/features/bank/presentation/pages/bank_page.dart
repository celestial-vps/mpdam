import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/features/bank/presentation/widgets/bank_body.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !controller.isLoadMore.value &&
        controller.pageIndex.value < controller.totalPages.value) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banks')),
      body: Obx(
        () => BankBody(
          banks: controller.banks,
          isLoading: controller.isLoading.value,
          isLoadMore: controller.isLoadMore.value,
          pageIndex: controller.pageIndex.value,
          totalPages: controller.totalPages.value,
          errorMessage: controller.errorMessage.value,
          onRefresh: () => controller.fetchBanks(refresh: true),
          scrollController: _scrollController,
        ),
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