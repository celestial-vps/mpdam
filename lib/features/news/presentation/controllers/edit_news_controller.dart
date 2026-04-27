import 'package:get/get.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:mpdam/features/news/domain/entities/update_news_entity.dart';
import 'package:mpdam/features/news/domain/usecases/get_news_by_id_usecase.dart';
import 'package:mpdam/features/news/domain/usecases/update_news_usecase.dart';

class EditNewsController extends GetxController {
  final GetNewsByIdUseCase getNewsByIdUseCase;
  final UpdateNewsUseCase updateNewsUseCase;

  EditNewsController({
    required this.getNewsByIdUseCase,
    required this.updateNewsUseCase,
  });

  var news = Rxn<News>();
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var errorMessage = ''.obs;

  Future<void> loadNews(String newsId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await getNewsByIdUseCase(newsId);
      result.fold(
        (failure) => errorMessage.value = failure.message,
        (data) => news.value = data,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateNews({
    required String author,
    required String category,
    required String publishedAt,
  }) async {
    final currentNews = news.value;
    if (currentNews == null) return false;

    final updatedEntity = UpdateNewsEntity(
      oid: currentNews.oid,
      author: author,
      category: category,
      content: '',
      image: '',
      language: '',
      publishedAt: publishedAt,
      status: '',
      summary: '',
      tags: '',
      title: '',
    );

    try {
      isUpdating.value = true;
      errorMessage.value = '';
      final result = await updateNewsUseCase(updatedEntity);
      bool success = false;
      result.fold((failure) => errorMessage.value = failure.message, (_) {
        news.value = News(
          oid: currentNews.oid,
          author: updatedEntity.author,
          category: updatedEntity.category,
          createdAt: currentNews.createdAt,
          updatedAt: DateTime.now(),
          content: '',
          image: null,
          language: '',
          publishedAt: publishedAt,
          status: '',
          summary: '',
          tags: '',
          title: '',
        );
        success = true;
      });
      return success;
    } finally {
      isUpdating.value = false;
    }
  }
}
