import 'package:flutter/material.dart';
import 'package:widgetbook/src/widgetbook_shell.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

import '../../widgetbook.dart';
import '../state/state.dart';
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
              path: _configuration.queryParams['path'] ?? '',
              panels: _configuration.queryParams['panels'] == null
                  ? WidgetbookPanel.values.toSet()
                  : WidgetbookPanelParser.parse(
                      _configuration.queryParams['panels']!,
                    ),
              queryParams: {
                ..._configuration.queryParams
              }, // Copy from UnmodifiableMap
              addons: addons,
              appBuilder: appBuilder,
              catalog: catalog,
            ),
            child: WidgetbookShell(
              child: Workbench(),
            ),
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
