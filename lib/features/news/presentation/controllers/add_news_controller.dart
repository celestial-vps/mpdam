import 'package:get/get.dart';
import 'package:mpdam/features/news/domain/usecases/create_news_usecase.dart';
import 'package:mpdam/features/news/domain/entities/create_news_entity.dart';

class AddNewsController extends GetxController {
  final CreateNewsUseCase createNewsUseCase;
  AddNewsController({required this.createNewsUseCase});

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var isSubmitted = false.obs;

  Future<void> submitNews(CreateNewsEntity news) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';
      final result = await createNewsUseCase(news);
      result.fold(
        (failure) => errorMessage.value = failure.message,
        (_) {
          successMessage.value = 'News berhasil ditambahkan';
          isSubmitted.value = true;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
