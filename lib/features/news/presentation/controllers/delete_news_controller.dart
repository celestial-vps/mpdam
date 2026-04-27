import 'package:get/get.dart';
import 'package:mpdam/features/news/domain/usecases/delete_news_usecase.dart';

class DeleteNewsController extends GetxController {
  final DeleteNewsUseCase deleteNewsUseCase;

  DeleteNewsController({required this.deleteNewsUseCase});

  var isDeleting = false.obs;

  /// Hanya mengembalikan true jika sukses, false jika gagal
  Future<bool> deleteNews(String newsId) async {
    try {
      isDeleting.value = true;

      final result = await deleteNewsUseCase.call(newsId);

      return result.fold(
        (failure) => false, // UI yang tangani snackbar
        (_) => true,
      );
    } finally {
      isDeleting.value = false;
    }
  }
}
