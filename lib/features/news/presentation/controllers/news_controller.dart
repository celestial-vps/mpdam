import 'package:get/get.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:mpdam/features/news/domain/entities/search_news_entity.dart';
import 'package:mpdam/features/news/domain/usecases/list_news_usecase.dart';

class NewsController extends GetxController {
  final GetInitNewsUseCase getInitNewsUseCase;

  NewsController({required this.getInitNewsUseCase});

  var newss = <News>[].obs;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var errorMessage = ''.obs;

  var pageIndex = 1;
  final int pageSize = 10;
  var totalPages = 1;

  NewsSearchParam? currentSearchParam;

  @override
  void onInit() {
    super.onInit();
    fetchNewss(refresh: true);
  }

  Future<void> fetchNewss({bool refresh = false, NewsSearchParam? searchParam}) async {
    if (refresh) {
      pageIndex = 1;
      newss.clear();
      if (searchParam != null) currentSearchParam = searchParam;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final result = await getInitNewsUseCase(
      PaggingParam(
        pageIndex: pageIndex,
        pageSize: pageSize,
        search: currentSearchParam?.search,
      ),
    );

    result.fold(
      (failure) {
        errorMessage.value = _failureMessage(failure);
      },
      (data) {
        totalPages = data.pagination.totalPage;
        newss.addAll(data.data);
        pageIndex++;
      },
    );

    isLoading.value = false;
  }

  Future<void> loadMore() async {
    if (isLoadMore.value || pageIndex > totalPages) return;

    isLoadMore.value = true;

    final result = await getInitNewsUseCase(
      PaggingParam(
        pageIndex: pageIndex,
        pageSize: pageSize,
        search: currentSearchParam?.search,
      ),
    );

    result.fold(
      (failure) => errorMessage.value = _failureMessage(failure),
      (data) {
        newss.addAll(data.data);
        pageIndex++;
      },
    );

    isLoadMore.value = false;
  }

  String _failureMessage(Failure failure) => failure.message ?? 'Terjadi kesalahan';
}
