import 'package:dio/dio.dart';
import 'package:leitor_manga/config/environment_config.dart';

class DioConfig {
  static final TOKEN_NAME = 'token-id';

  static final BaseOptions options = BaseOptions(
    baseUrl: EnvironmentConfig.SITE_ADDRESS,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static final Dio dio = Dio(options);

  static void addToken(String token) {
    options.headers ??= {};
    options.headers[TOKEN_NAME] = token;
  }

  static void removeToken() {
    if (options.headers != null && options.headers.containsKey(TOKEN_NAME)) {
      options.headers.remove(TOKEN_NAME);
    }
  }
}
