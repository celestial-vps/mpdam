import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mpdam/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/core/network/network_info.dart';

// Auth
import 'package:mpdam/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mpdam/features/auth/domain/repositories/auth_repository.dart';
import 'package:mpdam/features/auth/domain/usecases/login_usecase.dart';
import 'package:mpdam/core/storage/auth_local_datasource.dart';

// Customer Feature
import 'package:mpdam/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:mpdam/features/customer/data/repositories/customer_repository_imp.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';
import 'package:mpdam/features/customer/domain/usecases/get_all_customer_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/create_customer_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/update_customer_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/delete_customer_usecase.dart';
import 'package:mpdam/features/customer/presentation/controllers/customer_controller.dart';
import 'package:mpdam/features/customer/presentation/controllers/add_customer_controller.dart';

// Bank
import 'package:mpdam/features/bank/data/datasource/bank_remote_datasource.dart';
import 'package:mpdam/features/bank/data/repositories/bank_repository_imp.dart';
import 'package:mpdam/features/bank/domain/repositories/bank_repository.dart';
import 'package:mpdam/features/bank/domain/usecases/list_bank_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/create_bank_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/get_bank_by_id_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/update_bank_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/delete_delete_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  // Prevent duplicate registration (important when hot reload)
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance(),
    );
  }

  // Core
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  sl.registerLazySingleton<HttpManager>(() => AppHttpManager());

  // Auth Local Storage
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImplementation(sharedPreferences: sl()),
  );

  // Auth Remote
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplementation(httpManager: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(
      remote: sl(), // pastikan sudah ada AuthRemoteDataSource
      local: sl(), // pastikan sudah ada AuthLocalDataSource
      network: sl(), // pastikan sudah ada NetworkInfo
    ),
  );

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  // Customer ======================================================
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImplementation(httpManager: sl()),
  );

  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImplementation(
      networkInfo: sl(),
      customerRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<GetInitCustomerUseCase>(
    () => GetInitCustomerUseCase(sl()),
  );

  sl.registerLazySingleton<CreateCustomerUseCase>(
    () => CreateCustomerUseCase(sl()),
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

  sl.registerLazySingleton<CustomerController>(
    () => CustomerController(getInitCustomerUseCase: sl()),
  );

  sl.registerLazySingleton<AddCustomerController>(
    () => AddCustomerController(createCustomerUseCase: sl()),
  );

  // Bank ======================================================
  sl.registerLazySingleton<BankRemoteDataSource>(
    () => BankRemoteDataSourceImplementation(httpManager: sl()),
  );

  sl.registerLazySingleton<BankRepository>(
    () => BankRepositoryImplementation(
      networkInfo: sl(),
      bankRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<GetInitBankUseCase>(() => GetInitBankUseCase(sl()));
  sl.registerLazySingleton<CreateBankUseCase>(() => CreateBankUseCase(sl()));
  sl.registerLazySingleton<GetBankByIdUseCase>(() => GetBankByIdUseCase(sl()));
  sl.registerLazySingleton<UpdateBankUseCase>(() => UpdateBankUseCase(sl()));
  sl.registerLazySingleton<DeleteBankUseCase>(() => DeleteBankUseCase(sl()));
}
