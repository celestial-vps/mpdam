import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/features/bank/domain/entities/create_bank_entity.dart';
import 'package:mpdam/features/bank/presentation/controllers/add_bank_controller.dart';
import 'package:mpdam/service_locator.dart'; // <- pastikan import sl

class AddBankPage extends StatelessWidget {
  const AddBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _bankNameController = TextEditingController();
    final TextEditingController _bankCodeController = TextEditingController();

    // Ambil controller dari SL
    final AddBankController controller = sl<AddBankController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Bank')),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (controller.errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          controller.errorMessage.value,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    TextFormField(
                      controller: _bankNameController,
                      decoration: const InputDecoration(
                        labelText: 'Bank Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter bank bankName'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _bankCodeController,
                      decoration: const InputDecoration(
                        labelText: 'Bank Code',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter bank bankCode'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await controller.submitBank(
                                  CreateBankEntity(
                                    bankName: _bankNameController.text,
                                    bankCode: _bankCodeController.text,
                                  ),
                                );

                                if (controller.isSubmitted.value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        controller.successMessage.value,
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context, true);
                                }
                              }
                            },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
