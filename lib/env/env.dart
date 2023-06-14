import 'package:envied/envied.dart';

part 'env.g.dart';

// Edit .env file with the variables and run `flutter pub run build_runner build`

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'END_POINT')
  static String endPoint = _Env.endPoint;

  @EnviedField(varName: 'PROJECT_ID')
  static String projectId = _Env.projectId;
}
