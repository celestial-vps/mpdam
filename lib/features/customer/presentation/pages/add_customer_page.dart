// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mpdam/features/customer/presentation/controllers/add_customer_controller.dart';
// import 'package:mpdam/service_locator.dart';
// import 'package:mpdam/features/customer/presentation/widgets/add_customer_body.dart';

// class AddCustomerPage extends StatelessWidget {
//   AddCustomerPage({super.key});

//   // Inisialisasi controller menggunakan Get.put
//   final AddCustomerController controller = Get.put(
//     sl<AddCustomerController>(),
//     permanent: true, // optional
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Tambah Customer')),
//       body: AddCustomerBody(controller: controller), // <-- hanya panggil body
//     );
//   }
// }

// Bloc
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mpdam/features/customer/presentation/bloc/add/add_customer_bloc.dart';
// import 'package:mpdam/features/customer/presentation/bloc/add/add_customer_state.dart';
// import 'package:mpdam/features/customer/presentation/widgets/add_customer_body.dart';
// import 'package:mpdam/service_locator.dart';

// class AddCustomerPage extends StatelessWidget {
//   const AddCustomerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AddCustomerBloc(createCustomerUseCase: sl()),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Tambah Customer')),
//         body: BlocConsumer<AddCustomerBloc, AddCustomerState>(
//           listener: (context, state) {
//             if (state.isSubmitted) {
//               context.pop(true);
//             }
//           },
//           builder: (context, state) {
//             return AddCustomerBody(state: state);
//           },
//         ),
//       ),
//     );
//   }
// }
// Riverpod
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/customer/presentation/riverpod/add_customer/add_customer_state.dart';
import '../riverpod/add_customer/add_customer_provider.dart';
import '../widgets/add_customer_body.dart';

class AddCustomerPage extends ConsumerWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addCustomerProvider);
    final notifier = ref.read(addCustomerProvider.notifier);

    ref.listen<AddCustomerState>(addCustomerProvider, (previous, next) {
      if (next.isSubmitted) {
        context.pop(true);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Customer')),
      body: AddCustomerBody(
        state: state,
        onSubmit: (customer) => notifier.submitCustomer(customer),
      ),
    );
  }
}

