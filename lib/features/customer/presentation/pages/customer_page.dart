// GETX
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mpdam/features/customer/presentation/controllers/customer_controller.dart';
// import 'package:mpdam/features/customer/presentation/widgets/customer_body.dart';
// import 'package:mpdam/service_locator.dart';
// import 'package:go_router/go_router.dart';

// class CustomerPage extends StatefulWidget {
//   const CustomerPage({super.key});

//   @override
//   State<CustomerPage> createState() => _CustomerPageState();
// }

// class _CustomerPageState extends State<CustomerPage> {
//   final CustomerController controller = Get.put(sl<CustomerController>());
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 100 &&
//         !controller.isLoadMore.value &&
//         controller.pageIndex.value < controller.totalPages.value) {
//       controller.loadMore();
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Customers')),
//       body: Obx(
//         () => CustomerBody(
//           customers: controller.customers,
//           isLoading: controller.isLoading.value,
//           isLoadMore: controller.isLoadMore.value,
//           pageIndex: controller.pageIndex.value,
//           totalPages: controller.totalPages.value,
//           errorMessage: controller.errorMessage.value,
//           onRefresh: () => controller.fetchCustomers(refresh: true),
//           scrollController: _scrollController,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           final result = await context.push('/add-customer');
//           if (result == true) controller.fetchCustomers(refresh: true);
//         },
//       ),
//     );
//   }
// }

// lib/features/customer/presentation/pages/customer_page.dart

// BLOC
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mpdam/features/customer/presentation/bloc/customer/customer_bloc.dart';
// import 'package:mpdam/features/customer/presentation/bloc/customer/customer_event.dart';
// import 'package:mpdam/features/customer/presentation/bloc/customer/customer_state.dart';
// import 'package:mpdam/features/customer/presentation/widgets/customer_body.dart';
// import 'package:mpdam/service_locator.dart';

// class CustomerPage extends StatefulWidget {
//   const CustomerPage({super.key});

//   @override
//   State<CustomerPage> createState() => _CustomerPageState();
// }

// class _CustomerPageState extends State<CustomerPage> {
//   late final CustomerBloc bloc;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     bloc = CustomerBloc(getInitCustomerUseCase: sl())..add(FetchCustomers());
//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     final state = bloc.state;
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 100 &&
//         !state.isLoadMore &&
//         state.pageIndex < state.totalPages) {
//       bloc.add(LoadMoreCustomers());
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     bloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: bloc,
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Customers')),
//         body: BlocBuilder<CustomerBloc, CustomerState>(
//           builder: (context, state) {
//             return CustomerBody(
//               customers: state.customers,
//               isLoading: state.isLoading,
//               isLoadMore: state.isLoadMore,
//               pageIndex: state.pageIndex,
//               totalPages: state.totalPages,
//               errorMessage: state.errorMessage,
//               onRefresh: () async {
//                 bloc.add(FetchCustomers(refresh: true));
//               },
//               scrollController: _scrollController,
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () async {
//             final result = await context.push('/add-customer');
//             if (result == true) bloc.add(FetchCustomers(refresh: true));
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/features/customer/domain/entities/customer_search_param.dart';
import 'package:mpdam/features/customer/presentation/riverpod/customer/customer_provider.dart';
import 'package:mpdam/features/customer/presentation/riverpod/delete_customer/delete_customer_provider.dart';
import 'package:mpdam/features/customer/presentation/widgets/customer_body.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/customer/presentation/widgets/search_customer_bar.dart';

class CustomerPage extends ConsumerStatefulWidget {
  const CustomerPage({super.key});

  @override
  ConsumerState<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends ConsumerState<CustomerPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController(
    text: "dera",
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final notifier = ref.read(customerNotifierProvider.notifier);

    final state = ref.read(customerNotifierProvider);

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !state.isLoadMore &&
        state.pageIndex < state.totalPages) {
      notifier.loadMore();
    }
  }

  Future<void> _handleDeleteCustomer(String customerId) async {
    final deleteNotifier = ref.read(deleteCustomerProvider.notifier);
    final notifier = ref.read(customerNotifierProvider.notifier);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah kamu yakin ingin menghapus customer ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // Tampilkan loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final success = await deleteNotifier.deleteCustomer(customerId);

    // Tutup loading dialog
    Navigator.pop(context);

    if (success) {
      await notifier.fetchCustomers(refresh: true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Customer deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete customer'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerNotifierProvider);
    final notifier = ref.read(customerNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: Column(
        children: [
          // if (state.isSearching) const LinearProgressIndicator(minHeight: 2),

          // 🔍 Search Bar di atas list
          CustomerSearchBar(
            controller: _searchController,
            // onChanged: (query) => notifier.fetchCustomers(
            onChanged: (query) => notifier.fetchCustomers(
              refresh: true,
              searchParam: CustomerSearchParam(
                // search: query, // your search string
                search: {
                  'search': query, // map key-value untuk body dinamis
                },
                pagination: PaggingParam(
                  pageIndex: 1,
                  pageSize: 10,
                ), // reset to page 1
              ),
            ),

            onClear: () {
              _searchController.clear();
              notifier.fetchCustomers(refresh: true);
              FocusScope.of(context).unfocus();
            },
          ),
          Expanded(
            child: CustomerBody(
              customers: state.customers,
              isLoading: state.isLoading,
              isLoadMore: state.isLoadMore,
              pageIndex: state.pageIndex,
              totalPages: state.totalPages,
              errorMessage: state.errorMessage,
              onRefresh: () => notifier.fetchCustomers(refresh: true),
              scrollController: _scrollController,
              onEdit: (customer) {
                // navigasi ke halaman edit, misal pakai GoRouter
                // context.push('/edit-customer', extra: customer);
                context.push('/edit-customer', extra: customer.oid);
              },
              onDelete: (customer) {
                _handleDeleteCustomer(
                  customer.oid,
                ); // gunakan oid sebagai ID unik
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/add-customer');
          if (result == true) notifier.fetchCustomers(refresh: true);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
