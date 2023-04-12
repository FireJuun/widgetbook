import 'package:flutter/material.dart';

import '../../widgetbook.dart';
import '../state/state.dart';
import '../widgetbook_shell.dart';
import '../workbench/workbench.dart';
import 'route_configuration.dart';
import 'router_delegate_base.dart';

class RouterDelegate extends RouterDelegateBase {
  RouterDelegate({
    super.initialRoute = '/',
    required this.addons,
    required this.catalog,
    required this.appBuilder,
  }) : _configuration = RouteConfiguration(
          location: initialRoute,
        );

  RouteConfiguration _configuration;
  final List<WidgetbookAddOn> addons;
  final WidgetbookCatalog catalog;
  final AppBuilder appBuilder;

  @override
  RouteConfiguration? get currentConfiguration => _configuration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result) => route.didPop(result),
      pages: [
        MaterialPage(
          child: WidgetbookScope(
            state: WidgetbookState(
              path: _configuration.path,
              panels: _configuration.panels,
              queryParams: {
                 // Copy from UnmodifiableMap
                ..._configuration.queryParams
              },
              addons: addons,
              appBuilder: appBuilder,
              catalog: catalog,
            ),
            child: WidgetbookShell(
              child: Workbench(),
            ),

        ),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    _configuration = configuration;
    notifyListeners();
  }
}
