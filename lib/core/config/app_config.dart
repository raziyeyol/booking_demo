class AppConfig {
  final String baseUrl;
  final bool useMock;

  const AppConfig({required this.baseUrl, required this.useMock});

  static AppConfig fromEnvironment() {
    const envBaseUrl = String.fromEnvironment('BASE_URL',
        defaultValue: 'http://localhost:3000');
    const envUseMock = bool.fromEnvironment('USE_MOCK', defaultValue: false);
    const effectiveUseMock = envUseMock;
    return AppConfig(baseUrl: envBaseUrl, useMock: effectiveUseMock);
  }

  @override
  String toString() => 'AppConfig(baseUrl: $baseUrl, useMock: $useMock)';
}
