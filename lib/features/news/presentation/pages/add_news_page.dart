import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/features/news/domain/entities/create_news_entity.dart';
import 'package:mpdam/features/news/presentation/controllers/add_news_controller.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';

class AddNewsPage extends StatelessWidget {
  const AddNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _authorController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _publishedAtController =
        TextEditingController();

    // Inject controller per page
    final AddNewsController controller = Get.put(
      AddNewsController(createNewsUseCase: sl()),
      permanent: false,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Add News')),
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
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        labelText: 'News Code',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter news code'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _authorController,
                      decoration: const InputDecoration(
                        labelText: 'News Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter news name'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await controller.submitNews(
                                  CreateNewsEntity(
                                    author: _authorController.text,
                                    category: _categoryController.text,
                                    oid: '',
                                    content: '',
                                    image: '',
                                    language: '',
                                    publishedAt: _publishedAtController.text,
                                    status: '',
                                    summary: '',
                                    tags: '',
                                    title: '',
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
