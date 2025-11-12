import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mpdam/features/customer/domain/usecases/create_customer_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/delete_customer_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/update_customer_usecase.dart';
import 'package:mpdam/features/customer/presentation/controllers/add_customer_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/core/network/network_info.dart';

// Customer Feature
import 'package:mpdam/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:mpdam/features/customer/data/repositories/customer_repository_imp.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';
import 'package:mpdam/features/customer/domain/usecases/get_all_customer_usecase.dart';
import 'package:mpdam/features/customer/presentation/controllers/customer_controller.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  // ===== CORE DEPENDENCIES =====
  sl.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  sl.registerLazySingleton<HttpManager>(() => AppHttpManager());

  // ===== CUSTOMER FEATURE =====
  // 1. Datasource
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImplementation(httpManager: sl()),
  );

  // 2. Repository
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImplementation(
      networkInfo: sl(),
      customerRemoteDataSource: sl(),
    ),
  );

  // 3. Usecase
  sl.registerLazySingleton<GetInitCustomerUseCase>(
    () => GetInitCustomerUseCase(sl()),
  );
  sl.registerLazySingleton<CreateCustomerUseCase>(
    () => CreateCustomerUseCase(sl()), // biasanya inject repository
  );
  sl.registerLazySingleton<GetCustomerByIdUseCase>(
    () => GetCustomerByIdUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateCustomerUseCase>(
    () => UpdateCustomerUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteCustomerUseCase>(
    () => DeleteCustomerUseCase(sl()),
  );

  // 4. Controller (GetX)
  sl.registerLazySingleton<CustomerController>(
    () => CustomerController(getInitCustomerUseCase: sl()),
  );
  // sl.registerLazySingleton<CustomerController>(
  //   () => CustomerController(repository: sl()),
  // );

  // Controller untuk Add Customer

  sl.registerLazySingleton<AddCustomerController>(
    () => AddCustomerController(createCustomerUseCase: sl()),
  );
}
