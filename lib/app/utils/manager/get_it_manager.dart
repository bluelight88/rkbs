import 'package:get_it/get_it.dart';

import '../../core/controller/app_language_controller.dart';
import '../../modules/auth/model/repo/auth_repo.dart';
import '../../modules/dashboard/model/dashboard_repo_model.dart';
import '../../modules/provider_detail/model/provider_repo_model.dart';
import '../constants/apis.dart';
import '../services/package_services.dart';
import '../services/permission_manager.dart';
import 'api_controller.dart';
import 'storage_manager.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeGetItDependencies() async {
  getIt.registerSingleton<APIS>(APIS());
  getIt.registerSingleton<APIController>(APIController());
  getIt.registerSingleton<PackageServices>(PackageServices());
  getIt.registerSingleton<PermissionManager>(PermissionManager());
  getIt.registerSingleton<StorageManager>(StorageManager());
  getIt.registerLazySingleton<AppLanguageController>(
    () => AppLanguageController(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo());
  getIt.registerLazySingleton<DashBoardRepo>(() => DashBoardRepo());
  getIt.registerLazySingleton<ProviderRepo>(() => ProviderRepo());
}
