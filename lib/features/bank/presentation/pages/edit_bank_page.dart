import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/presentation/controllers/edit_bank_controller.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';

class EditBankPage extends StatefulWidget {
  final String bankId;

  const EditBankPage({super.key, required this.bankId});

  @override
  State<EditBankPage> createState() => _EditBankPageState();
}

class _EditBankPageState extends State<EditBankPage> {
  late TextEditingController bankCodeController;
  late TextEditingController bankNameController;

  late EditBankController controller; // jangan pakai final
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    // Buat controller baru setiap kali page dibuka
    Get.create<EditBankController>(
      () =>
          EditBankController(getBankByIdUseCase: sl(), updateBankUseCase: sl()),
    );

    // Ambil instance controller yang baru dibuat
    controller = Get.find<EditBankController>();

    bankCodeController = TextEditingController();
    bankNameController = TextEditingController();

    // Load data bank setelah frame build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.bank.value = null;
      controller.errorMessage.value = '';
      controller.isLoading.value = true;
      controller.loadBank(widget.bankId);
    });
  }

  @override
  void dispose() {
    bankCodeController.dispose();
    bankNameController.dispose();

    // Hancurkan controller saat page dispose agar edit berikutnya fresh
    Get.delete<EditBankController>();

    super.dispose();
  }

  void _setInitialText(Bank bank) {
    if (_initialized) return;

    bankCodeController.text = bank.bankCode;
    bankNameController.text = bank.bankName;

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Bank")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bank = controller.bank.value;
        if (bank == null) {
          return Center(
            child: Text(
              controller.errorMessage.isNotEmpty
                  ? controller.errorMessage.value
                  : "Bank not found",
            ),
          );
        }

        _setInitialText(bank);

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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Update Bank"),
                      if (controller.isUpdating.value) ...[
                        const SizedBox(width: 10),
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
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
