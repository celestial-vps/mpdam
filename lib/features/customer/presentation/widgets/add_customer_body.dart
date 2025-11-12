// GETX
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mpdam/features/customer/presentation/controllers/add_customer_controller.dart';

// class AddCustomerBody extends StatelessWidget {
//   final AddCustomerController controller;

//   const AddCustomerBody({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Obx(
//         () => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // First Name
//             TextField(
//               controller: controller.firstNameController,
//               decoration: const InputDecoration(labelText: 'First Name'),
//             ),
//             const SizedBox(height: 8),

//             // Middle Name
//             TextField(
//               controller: controller.middleNameController,
//               decoration: const InputDecoration(labelText: 'Middle Name'),
//             ),
//             const SizedBox(height: 8),

//             // Last Name
//             TextField(
//               controller: controller.lastNameController,
//               decoration: const InputDecoration(labelText: 'Last Name'),
//             ),
//             const SizedBox(height: 8),

//             // Email
//             TextField(
//               controller: controller.emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 8),

//             // Phone Number
//             TextField(
//               controller: controller.phoneController,
//               decoration: const InputDecoration(labelText: 'Phone Number'),
//             ),
//             const SizedBox(height: 8),

//             // Address
//             TextField(
//               controller: controller.addressController,
//               decoration: const InputDecoration(labelText: 'Address'),
//             ),
//             const SizedBox(height: 16),

//             // Error message
//             if (controller.errorMessage.isNotEmpty)
//               Text(
//                 controller.errorMessage.value,
//                 style: const TextStyle(color: Colors.red),
//               ),

//             // Success message
//             if (controller.successMessage.isNotEmpty)
//               Text(
//                 controller.successMessage.value,
//                 style: const TextStyle(color: Colors.green),
//               ),
//             const SizedBox(height: 16),

//             // Submit button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: controller.isLoading.value
//                     ? null
//                     : () async {
//                         final success = await controller.addCustomer();
//                         if (success) context.pop(true);
//                       },
//                 child: controller.isLoading.value
//                     ? const SizedBox(
//                         width: 24,
//                         height: 24,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : const Text('Simpan'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// BLOC
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mpdam/features/customer/presentation/bloc/add/add_customer_bloc.dart';
// import 'package:mpdam/features/customer/presentation/bloc/add/add_customer_event.dart';
// import 'package:mpdam/features/customer/presentation/bloc/add/add_customer_state.dart';

// class AddCustomerBody extends StatefulWidget {
//   final AddCustomerState state;

//   const AddCustomerBody({super.key, required this.state});

//   @override
//   State<AddCustomerBody> createState() => _AddCustomerBodyState();
// }

// class _AddCustomerBodyState extends State<AddCustomerBody> {
//   final firstNameController = TextEditingController(text: "Alex");
//   final middleNameController = TextEditingController(text: "Abad");
//   final lastNameController = TextEditingController(text: "Dalem");
//   final emailController = TextEditingController(text: "alex@gmail.com");
//   final phoneController = TextEditingController(text: "012938123123");
//   final addressController = TextEditingController(text: "Jl Sukapura no 68");

//   @override
//   void dispose() {
//     firstNameController.dispose();
//     middleNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = widget.state;
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(controller: firstNameController, decoration: const InputDecoration(labelText: 'First Name')),
//           const SizedBox(height: 8),
//           TextField(controller: middleNameController, decoration: const InputDecoration(labelText: 'Middle Name')),
//           const SizedBox(height: 8),
//           TextField(controller: lastNameController, decoration: const InputDecoration(labelText: 'Last Name')),
//           const SizedBox(height: 8),
//           TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
//           const SizedBox(height: 8),
//           TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone Number')),
//           const SizedBox(height: 8),
//           TextField(controller: addressController, decoration: const InputDecoration(labelText: 'Address')),
//           const SizedBox(height: 16),

//           if (state.errorMessage.isNotEmpty)
//             Text(state.errorMessage, style: const TextStyle(color: Colors.red)),

//           if (state.successMessage.isNotEmpty)
//             Text(state.successMessage, style: const TextStyle(color: Colors.green)),

//           const SizedBox(height: 16),

//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: state.isLoading
//                   ? null
//                   : () {
//                       context.read<AddCustomerBloc>().add(
//                             SubmitCustomer(
//                               firstName: firstNameController.text.trim(),
//                               middleName: middleNameController.text.trim(),
//                               lastName: lastNameController.text.trim(),
//                               email: emailController.text.trim(),
//                               phone: phoneController.text.trim(),
//                               address: addressController.text.trim(),
//                             ),
//                           );
//                     },
//               child: state.isLoading
//                   ? const SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ),
//                     )
//                   : const Text('Simpan'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../domain/entities/create_customer_entity.dart';
import '../riverpod/add_customer/add_customer_state.dart';

class AddCustomerBody extends StatefulWidget {
  final AddCustomerState state;
  final Function(CreateCustomerEntity) onSubmit;

  const AddCustomerBody({super.key, required this.state, required this.onSubmit});

  @override
  State<AddCustomerBody> createState() => _AddCustomerBodyState();
}

class _AddCustomerBodyState extends State<AddCustomerBody> {
  final firstNameController = TextEditingController(text: "Alex");
  final middleNameController = TextEditingController(text: "Abad");
  final lastNameController = TextEditingController(text: "Dalem");
  final emailController = TextEditingController(text: "alex@gmail.com");
  final phoneController = TextEditingController(text: "012938123123");
  final addressController = TextEditingController(text: "Jl Sukapura no 68");

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(controller: firstNameController, decoration: const InputDecoration(labelText: 'First Name')),
          const SizedBox(height: 8),
          TextField(controller: middleNameController, decoration: const InputDecoration(labelText: 'Middle Name')),
          const SizedBox(height: 8),
          TextField(controller: lastNameController, decoration: const InputDecoration(labelText: 'Last Name')),
          const SizedBox(height: 8),
          TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 8),
          TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone Number')),
          const SizedBox(height: 8),
          TextField(controller: addressController, decoration: const InputDecoration(labelText: 'Address')),
          const SizedBox(height: 16),
          if (state.errorMessage.isNotEmpty)
            Text(state.errorMessage, style: const TextStyle(color: Colors.red)),
          if (state.successMessage.isNotEmpty)
            Text(state.successMessage, style: const TextStyle(color: Colors.green)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () {
                      widget.onSubmit(
                        CreateCustomerEntity(
                          firstName: firstNameController.text.trim(),
                          middleName: middleNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                          address: addressController.text.trim(),
                        ),
                      );
                    },
              child: state.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}
