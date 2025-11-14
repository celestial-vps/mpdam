import 'package:get/get.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/domain/entities/search_bank_entity.dart';
import 'package:mpdam/features/bank/domain/usecases/list_bank_usecase.dart';

class BankController extends GetxController {
  final GetInitBankUseCase getInitBankUseCase;

  BankController({required this.getInitBankUseCase});

  var banks = <Bank>[].obs;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var errorMessage = ''.obs;

  var pageIndex = 1;
  final int pageSize = 10;
  var totalPages = 1;

  BankSearchParam? currentSearchParam;

  @override
  void onInit() {
    super.onInit();
    fetchBanks(refresh: true);
  }

  Future<void> fetchBanks({bool refresh = false, BankSearchParam? searchParam}) async {
    if (refresh) {
      pageIndex = 1;
      banks.clear();
      if (searchParam != null) currentSearchParam = searchParam;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final result = await getInitBankUseCase(
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
        banks.addAll(data.data);
        pageIndex++;
      },
    );

    isLoading.value = false;
  }

  Future<void> loadMore() async {
    if (isLoadMore.value || pageIndex > totalPages) return;

    isLoadMore.value = true;

    final result = await getInitBankUseCase(
      PaggingParam(
        pageIndex: pageIndex,
        pageSize: pageSize,
        search: currentSearchParam?.search,
      ),
    );

    result.fold(
      (failure) => errorMessage.value = _failureMessage(failure),
      (data) {
        banks.addAll(data.data);
        pageIndex++;
      },
    );

    isLoadMore.value = false;
  }

  String _failureMessage(Failure failure) => failure.message ?? 'Terjadi kesalahan';
}
