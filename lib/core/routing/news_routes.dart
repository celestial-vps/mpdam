import 'package:go_router/go_router.dart';
import 'package:mpdam/features/news/bindings/news_bindings.dart';
import 'package:mpdam/features/news/presentation/pages/add_news_page.dart';
import 'package:mpdam/features/news/presentation/pages/edit_news_page.dart';
import 'package:mpdam/features/news/presentation/pages/news_page.dart';

final newsRoutes = [
  GoRoute(
    path: '/news',
    builder: (context, state) {
      NewsBindings.init();
      return NewsPage();
    },
  ),
  GoRoute(
    path: '/add-news',
    builder: (context, state) {
      NewsBindings.init();
      return AddNewsPage();
    },
  ),
  GoRoute(
    path: '/edit-news',
    builder: (context, state) {
      NewsBindings.init();
      final newsId = state.extra as String;
      return EditNewsPage(newsId: newsId);
    },
  ),
];
