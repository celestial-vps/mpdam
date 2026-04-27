import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/widgets/app_confirm_dialog.dart';
import 'package:mpdam/core/widgets/app_search_bar.dart';
import 'package:mpdam/features/news/domain/entities/search_news_entity.dart';
import 'package:mpdam/features/news/presentation/controllers/delete_news_controller.dart';
import 'package:mpdam/features/news/presentation/controllers/news_controller.dart';
import 'package:mpdam/features/news/presentation/widgets/news_body.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _scrollController = ScrollController();
  final NewsController controller = Get.find<NewsController>();
    final DeleteNewsController deleteController =
      Get.find<DeleteNewsController>();

  final TextEditingController _searchController = TextEditingController(
    text: "",
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !controller.isLoadMore.value &&
        controller.pageIndex <= controller.totalPages) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete(String newsId) async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: "Delete News",
      message: "Are you sure you want to delete this news?",
    );

    if (!confirmed) return;

    // Tampilkan loading pakai context
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final success = await deleteController.deleteNews(newsId);

    // Tutup loading
    if (Navigator.canPop(context)) Navigator.pop(context);

    if (success) {
      controller.fetchNewss(refresh: true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("News deleted successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete news"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Newss')),
      body: Column(
        children: [
          AppSearchBar(
            controller: _searchController,
            onChanged: (query) {
              controller.fetchNewss(
                refresh: true,
                searchParam: NewsSearchParam(
                  search: {'search': query},
                  pagination: PaggingParam(pageIndex: 1, pageSize: 10),
                ),
              );
            },
            onClear: () async {
              _searchController.clear();
              controller.isLoading.value = true;
              FocusScope.of(context).unfocus();
              await controller.fetchNewss(
                refresh: true,
                searchParam: NewsSearchParam(
                  search: {}, // kosongkan search
                  pagination: PaggingParam(pageIndex: 1, pageSize: 10),
                ),
              );
              // controller.fetchNewss(refresh: true);
            },
          ),
          Expanded(
            child: Obx(
              () => NewsBody(
                newss: controller.newss,
                isLoading: controller.isLoading.value,
                isLoadMore: controller.isLoadMore.value,
                pageIndex: controller.pageIndex,
                totalPages: controller.totalPages,
                errorMessage: controller.errorMessage.value,
                onRefresh: () => controller.fetchNewss(refresh: true),
                scrollController: _scrollController,
                // onEdit: (news) => context.push('/edit-news', extra: news.oid),
                onEdit: (news) async {
                  final result = await context.push(
                    '/edit-news',
                    extra: news.oid,
                  );
                  if (result == true) {
                    controller.fetchNewss(
                      refresh: true,
                    ); // fetch ulang data terbaru
                  }
                },
                onDelete: (news) => _confirmDelete(news.oid),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await context.push('/add-news');
          if (result == true) controller.fetchNewss(refresh: true);
        },
      ),
    );
  }
}
