class RouteConfiguration {
  const RouteConfiguration({
    required this.location,
  });

  final String location;

  Map<String, String> get queryParams {
    final uri = Uri.parse(location);
    return uri.queryParameters;
  }
}
