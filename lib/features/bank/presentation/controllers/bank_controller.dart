import 'package:get/get.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/domain/usecases/list_customer_usecase.dart';


class BankController extends GetxController {
  final GetInitBankUseCase getInitBankUseCase;

  BankController({required this.getInitBankUseCase});

  var banks = <Bank>[].obs;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var errorMessage = ''.obs;

  var pageIndex = 1.obs;
  var pageSize = 10;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanks();
  }

  Future<void> fetchBanks({bool refresh = false}) async {
    if (refresh) pageIndex.value = 1;
    isLoading.value = true;
    errorMessage.value = '';

    final result = await getInitBankUseCase(
      PaggingParam(pageIndex: pageIndex.value, pageSize: pageSize),
    );

    result.fold(
      (failure) {
        errorMessage.value = _failureMessage(failure);
        if (refresh) banks.clear();
      },
      (data) {
        totalPages.value = data.pagination.totalPage;
        if (refresh) {
          banks.value = data.data;
        } else {
          banks.assignAll(data.data);
        }
      },
    );

    isLoading.value = false;
  }

  Future<void> loadMore() async {
    if (isLoadMore.value || pageIndex.value >= totalPages.value) return;
    isLoadMore.value = true;
    pageIndex.value += 1;

    final result = await getInitBankUseCase(
      PaggingParam(pageIndex: pageIndex.value, pageSize: pageSize),
    );

    result.fold(
      (failure) => errorMessage.value = _failureMessage(failure),
      (data) => banks.addAll(data.data),
    );

    isLoadMore.value = false;
  }

  String _failureMessage(Failure failure) => failure.message ?? 'Terjadi kesalahan';
}
