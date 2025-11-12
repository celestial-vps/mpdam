import 'package:get/get.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:mpdam/features/customer/domain/usecases/get_all_customer_usecase.dart';

class CustomerController extends GetxController {
  final GetInitCustomerUseCase getInitCustomerUseCase;

  CustomerController({required this.getInitCustomerUseCase});

  var customers = <Customer>[].obs;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var errorMessage = ''.obs;

  var pageIndex = 1.obs;
  var pageSize = 10;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
  }

  Future<void> fetchCustomers({bool refresh = false}) async {
    if (refresh) pageIndex.value = 1;
    isLoading.value = true;
    errorMessage.value = '';

    final result = await getInitCustomerUseCase(
      PaggingParam(pageIndex: pageIndex.value, pageSize: pageSize),
    );

    result.fold(
      (failure) {
        errorMessage.value = _failureMessage(failure);
        if (refresh) customers.clear();
      },
      (data) {
        totalPages.value = data.pagging.totalPage;
        if (refresh) {
          customers.value = data.data;
        } else {
          customers.assignAll(data.data);
        }
      },
    );

    isLoading.value = false;
  }

  Future<void> loadMore() async {
    if (isLoadMore.value || pageIndex.value >= totalPages.value) return;
    isLoadMore.value = true;
    pageIndex.value += 1;

    final result = await getInitCustomerUseCase(
      PaggingParam(pageIndex: pageIndex.value, pageSize: pageSize),
    );

    result.fold(
      (failure) => errorMessage.value = _failureMessage(failure),
      (data) => customers.addAll(data.data),
    );

    isLoadMore.value = false;
  }

  String _failureMessage(Failure failure) => failure.message ?? 'Terjadi kesalahan';
}
