// FILE: features/bank/bindings/bank_bindings.dart
import 'package:get/get.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';
import 'package:mpdam/features/news/domain/usecases/create_news_usecase.dart';
import 'package:mpdam/features/news/domain/usecases/delete_news_usecase.dart';
import 'package:mpdam/features/news/domain/usecases/get_news_by_id_usecase.dart';
import 'package:mpdam/features/news/domain/usecases/list_news_usecase.dart';
import 'package:mpdam/features/news/domain/usecases/update_news_usecase.dart';
import 'package:mpdam/features/news/presentation/controllers/add_News_controller.dart';
import 'package:mpdam/features/news/presentation/controllers/delete_news_controller.dart';
import 'package:mpdam/features/news/presentation/controllers/edit_news_controller.dart';
import 'package:mpdam/features/news/presentation/controllers/news_controller.dart';
 
class NewsBindings {
  static void init() {
    // ===========================
    // Controllers
    // ===========================
    Get.lazyPut<NewsController>(
      () => NewsController(getInitNewsUseCase: GetInitNewsUseCase(sl())),
      fenix: true,
    );

    Get.lazyPut<EditNewsController>(
      () => EditNewsController(
        getNewsByIdUseCase: GetNewsByIdUseCase(sl()),
        updateNewsUseCase: UpdateNewsUseCase(sl()),
      ),
      fenix: false,
    );

    Get.lazyPut<DeleteNewsController>(
      () => DeleteNewsController(
        deleteNewsUseCase: DeleteNewsUseCase(sl()),
      ),
      fenix: false,
    );

    Get.lazyPut<AddNewsController>(
      () => AddNewsController(
        createNewsUseCase: CreateNewsUseCase(sl()),
      ),
      fenix: true,
    );
  }
}
