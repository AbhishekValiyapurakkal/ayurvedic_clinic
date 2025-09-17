abstract class Environment {
  static const String dev = 'development';
  static const String prod = 'production';

  static String get baseUrl {
    if (const bool.hasEnvironment('ENV')) {
      return const String.fromEnvironment('ENV') == prod
          ? 'https://flutter-amr.noviindus.in/api/'
          : 'https://flutter-amr.noviindus.in/api/';
    }
    return 'https://flutter-amr.noviindus.in/api/';
  }
}
