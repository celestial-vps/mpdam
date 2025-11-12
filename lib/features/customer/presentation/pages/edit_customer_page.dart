import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/features/customer/presentation/riverpod/edit_customer/edit_customer_provider.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';

class EditCustomerPage extends ConsumerStatefulWidget {
  final String customerId;

  const EditCustomerPage({super.key, required this.customerId});

  @override
  ConsumerState<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends ConsumerState<EditCustomerPage> {
  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    // Fetch data customer berdasarkan ID
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editCustomerProvider.notifier).loadCustomer(widget.customerId);
    });
  }

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
    final state = ref.watch(editCustomerProvider);

    final customer = state.customer;
    if (customer != null && firstNameController.text.isEmpty) {
      firstNameController.text = customer.firstName;
      middleNameController.text = customer.middleName;
      lastNameController.text = customer.lastName;
      emailController.text = customer.email;
      phoneController.text = customer.phoneNumber;
      addressController.text = customer.address;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Customer')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextField(
                      controller: middleNameController,
                      decoration: const InputDecoration(
                        labelText: 'Middle Name',
                      ),
                    ),
                    TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state.isUpdating
                          ? null
                          : () async {
                              final customer = state.customer;
                              if (customer != null) {
                                final updated = Customer(
                                  oid: customer.oid,
                                  firstName: firstNameController.text,
                                  middleName: middleNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  phoneNumber: phoneController.text,
                                  address: addressController.text,
                                  createdAt: customer.createdAt,
                                  updatedAt: DateTime.now(),
                                );

                                await ref
                                    .read(editCustomerProvider.notifier)
                                    .updateCustomer(updated);

                                final newState = ref.read(editCustomerProvider);

                                if (newState.errorMessage.isEmpty) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Customer berhasil diperbarui',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pop(context, true);
                                  }
                                }
                              }
                            },
                      child: state.isUpdating
                          ? const CircularProgressIndicator()
                          : const Text('Update Customer'),
                    ),
                    if (state.errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
