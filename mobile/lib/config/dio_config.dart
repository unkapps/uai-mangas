import 'package:dio/dio.dart';
import 'package:leitor_manga/config/environment_config.dart';

class DioConfig {
  static final BaseOptions options = BaseOptions(
    baseUrl: EnvironmentConfig.SITE_ADDRESS,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static final Dio dio = Dio(options);
}
