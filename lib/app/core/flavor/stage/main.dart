import '../../../../main.dart';
import '../../../utils/constants/app_config.dart';

void main() {
  AppConfig.instance.setEnvironment(Environment.stage);
  mainDelegate();
}
