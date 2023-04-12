import 'router_delegate.dart';

extension GoRouterExtension on RouterDelegate {
  void updateQueryParam(String name, String value) {
    final uri = Uri.parse(currentConfiguration?.location ?? '/');

    // TODO
    // goNamed(
    //   '/',
    //   queryParams: {
    //     ...uri.queryParameters,
    //     name: value,
    //   },
    // );
  }
}
