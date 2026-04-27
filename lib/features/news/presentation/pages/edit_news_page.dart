import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:mpdam/features/news/presentation/controllers/edit_news_controller.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';

class EditNewsPage extends StatefulWidget {
  final String newsId;

  const EditNewsPage({super.key, required this.newsId});

  @override
  State<EditNewsPage> createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  late TextEditingController authorController;
  late TextEditingController categoryController;
  late TextEditingController publishedAtController;

  late EditNewsController controller; // jangan pakai final
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    // Buat controller baru setiap kali page dibuka
    Get.create<EditNewsController>(
      () =>
          EditNewsController(getNewsByIdUseCase: sl(), updateNewsUseCase: sl()),
    );

    // Ambil instance controller yang baru dibuat
    controller = Get.find<EditNewsController>();

    authorController = TextEditingController();
    categoryController = TextEditingController();

    // Load data news setelah frame build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.news.value = null;
      controller.errorMessage.value = '';
      controller.isLoading.value = true;
      controller.loadNews(widget.newsId);
    });
  }

  @override
  void dispose() {
    authorController.dispose();
    categoryController.dispose();

    // Hancurkan controller saat page dispose agar edit berikutnya fresh
    Get.delete<EditNewsController>();

    super.dispose();
  }

  void _setInitialText(News news) {
    if (_initialized) return;

    authorController.text = news.author;
    categoryController.text = news.category;

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit News")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final news = controller.news.value;
        if (news == null) {
          return Center(
            child: Text(
              controller.errorMessage.isNotEmpty
                  ? controller.errorMessage.value
                  : "News not found",
            ),
          );
        }

        _setInitialText(news);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'News Code'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'News Name'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.isUpdating.value
                      ? null
                      : () async {
                          final success = await controller.updateNews(
                            author: authorController.text,
                            category: categoryController.text, publishedAt: publishedAtController.text,
                          );

                          if (!success) return;

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("News updated successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Navigator.pop(context, true);
                          }
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Update News"),
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
