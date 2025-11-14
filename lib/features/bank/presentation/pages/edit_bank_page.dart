import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/presentation/controllers/edit_bank_controller.dart';
import 'package:mpdam/service_locator.dart';

class EditBankPage extends StatefulWidget {
  final String bankId;

  const EditBankPage({super.key, required this.bankId});

  @override
  State<EditBankPage> createState() => _EditBankPageState();
}

class _EditBankPageState extends State<EditBankPage> {
  late TextEditingController bankCodeController;
  late TextEditingController bankNameController;

  late EditBankController controller;

  @override
  void initState() {
    super.initState();
    bankCodeController = TextEditingController();
    bankNameController = TextEditingController();

    // Ambil controller dari service_locator
    controller = sl<EditBankController>();

    // Load bank
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadBank(widget.bankId);
    });
  }

  @override
  void dispose() {
    bankCodeController.dispose();
    bankNameController.dispose();
    super.dispose();
  }

  // Auto update field ketika data bank berhasil di-load
  void _fillFields(Bank bank) {
    bankCodeController.text = bank.bankCode;
    bankNameController.text = bank.bankName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Bank")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bank.value == null) {
          return Center(
            child: Text(controller.errorMessage.isNotEmpty
                ? controller.errorMessage.value
                : "Bank not found"),
          );
        }

        // isi input jika belum terisi
        _fillFields(controller.bank.value!);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: bankCodeController,
                  decoration: const InputDecoration(labelText: 'Bank Code'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: bankNameController,
                  decoration: const InputDecoration(labelText: 'Bank Name'),
                ),
                const SizedBox(height: 20),

                // Tombol update
                ElevatedButton(
                  onPressed: controller.isUpdating.value
                      ? null
                      : () async {
                          final success = await controller.updateBank(
                            bankCode: bankCodeController.text,
                            bankName: bankNameController.text,
                          );

                          if (!success) return;

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Bank updated successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context, true);
                          }
                        },
                  child: controller.isUpdating.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Update Bank"),
                ),

                const SizedBox(height: 10),

                if (controller.errorMessage.isNotEmpty)
                  Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
