import 'package:flutter/material.dart' hide RouterDelegate;
import 'package:widgetbook/src/routing/route_configuration.dart';
import 'package:widgetbook/src/routing/route_parser.dart';
import 'package:widgetbook/src/routing/router_delegate.dart';

import '../addons/addons.dart';
import '../state/state.dart';

class AppRouter extends Router<RouteConfiguration> {
  AppRouter({
    String initialRoute = '/',
    required List<WidgetbookAddOn> addons,
    required WidgetbookCatalog catalog,
    required AppBuilder appBuilder,
  }) : super(
          routerDelegate: RouterDelegate(
              initialRoute: initialRoute,
              addons: addons,
              catalog: catalog,
              appBuilder: appBuilder),
          routeInformationParser: RouteParser(),
          routeInformationProvider: PlatformRouteInformationProvider(
            initialRouteInformation: RouteInformation(
              location: initialRoute,
            ),
          ),
        );
}
