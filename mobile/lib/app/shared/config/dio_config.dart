import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/auth/auth.service.dart';
import 'package:leitor_manga/app/shared/config/environment_config.dart';
import 'package:leitor_manga/app/shared/exceptions/no_token_exception.dart';

class DioConfig {
  static final TOKEN_NAME = 'token-id';

  static final BaseOptions options = BaseOptions(
    baseUrl: EnvironmentConfig.SITE_ADDRESS,
    connectTimeout: 20000,
  );

  static Future<Dio> withoutToken() async {
    return Dio(options);
  }

  static Future<Dio> withToken({tokenIsRequired = false}) async {
    final userService = Modular.get<AuthService>();
    final token = await userService.getToken();

    if (tokenIsRequired && token == null) {
      throw NoTokenException();
    }

    return Dio(options.merge(headers: {TOKEN_NAME: token}));
  }
}
