import 'package:flutter/widgets.dart';

import 'route_configuration.dart';

abstract class RouterDelegateBase extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  RouterDelegateBase({
    required this.initialRoute,
  }) : _navigatorKey = GlobalKey<NavigatorState>();

  final String initialRoute;
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}
