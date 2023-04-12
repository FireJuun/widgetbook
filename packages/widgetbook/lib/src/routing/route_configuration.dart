import '../state/state.dart';

class RouteConfiguration {
  RouteConfiguration({
    required this.location,
  }) : queryParameters = Uri.parse(location).queryParameters;

  final String location;
  final Map<String, String> queryParameters;

  Map<String, String> get queryParams {
    final uri = Uri.parse(location);
    return uri.queryParameters;
  }

  String get path => queryParameters['path'] ?? '';

  Set<WidgetbookPanel> get panels {
    final parameter = queryParameters['panels'];

    if (parameter == null) {
      return WidgetbookPanel.values.toSet();
    }

    if (parameter.isEmpty || parameter == '{}') {
      return {};
    }

    return parameter
        .replaceAll(RegExp('[{}]'), '')
        .split(',')
        .map((name) => WidgetbookPanel.values.byName(name))
        .toSet();
  }
}
