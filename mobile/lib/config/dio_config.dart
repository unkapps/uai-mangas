import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/config/environment_config.dart';
import 'package:leitor_manga/user/user.service.dart';

class DioConfig {
  static final getIt = GetIt.instance;

  static final TOKEN_NAME = 'token-id';

  static final BaseOptions options = BaseOptions(
    baseUrl: EnvironmentConfig.SITE_ADDRESS,
    connectTimeout: 20000,
  );

  static Future<Dio> withoutToken() async {
    return Dio(options);
  }

  static Future<Dio> withToken() async {
    final userService = getIt<UserService>();
    final token = await userService.getToken();
    return Dio(options.merge(headers: {TOKEN_NAME: token}));
  }
}
