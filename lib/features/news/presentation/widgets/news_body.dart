import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NewsBody extends StatelessWidget {
  final List<News> newss;
  final bool isLoading;
  final bool isLoadMore;
  final int pageIndex;
  final int totalPages;
  final String errorMessage;
  final Future<void> Function()? onRefresh;
  final ScrollController? scrollController;
  final void Function(News news)? onEdit;
  final void Function(News news)? onDelete;

  const NewsBody({
    super.key,
    required this.newss,
    required this.isLoading,
    required this.isLoadMore,
    required this.pageIndex,
    required this.totalPages,
    required this.errorMessage,
    this.onRefresh,
    this.scrollController,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage.isNotEmpty && newss.isEmpty) {
      return Center(child: Text(errorMessage));
    }

    if (newss.isEmpty) {
      return const Center(child: Text('No newss found'));
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: newss.length + (isLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < newss.length) {
            final news = newss[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Slidable(
                key: ValueKey(news.oid), // pastikan setiap news punya id unik
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) => onEdit?.call(news),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (_) => onDelete?.call(news),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  child: ListTile(
                    title: Text('${news.author} '),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Html(
                          data:
                              """
         ${news.content}
        """,
                          extensions: [
                            TagExtension(
                              tagsToExtend: {"flutter"},
                              child: const FlutterLogo(),
                            ),
                          ],
                          style: {
                            "p.fancy": Style(
                              textAlign: TextAlign.center,
                              // padding: const EdgeInsets.all(16),
                              backgroundColor: Colors.grey,
                              margin: Margins(
                                left: Margin(50, Unit.px),
                                right: Margin.auto(),
                              ),
                              width: Width(300, Unit.px),
                              fontWeight: FontWeight.bold,
                            ),
                          },
                        ),
                        // Html('News Name: ${news.content}'),
                        // Text('Phone: ${news.shortName}'),
                        // Text('Created: ${news.createdAt.toLocal()}'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
