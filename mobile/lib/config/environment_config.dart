class EnvironmentConfig {
  static const SITE_ADDRESS = String.fromEnvironment('MANGA_SITE_ADDRESS',
      defaultValue: 'http://192.168.0.2:3000');
}
