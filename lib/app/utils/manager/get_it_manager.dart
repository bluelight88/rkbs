import 'package:get_it/get_it.dart';

import '../../core/controller/app_language_controller.dart';
import '../../modules/auth/model/repo/auth_repo.dart';
import '../services/package_services.dart';
import '../services/permission_manager.dart';
import 'api_controller.dart';
import 'storage_manager.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeGetItDependencies() async {
  getIt.registerSingleton<APIController>(APIController());
  getIt.registerSingleton<PackageServices>(PackageServices());
  getIt.registerSingleton<PermissionManager>(PermissionManager());
  getIt.registerSingleton<StorageManager>(StorageManager());
  getIt.registerLazySingleton<AppLanguageController>(
    () => AppLanguageController(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo());
}
