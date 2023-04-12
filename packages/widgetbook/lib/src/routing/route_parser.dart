import 'package:flutter/material.dart';

import 'route_configuration.dart';

class RouteParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return RouteConfiguration(
      location: routeInformation.location ?? '/',
    );
  }

  @override
  RouteInformation restoreRouteInformation(
    RouteConfiguration configuration,
  ) {
    return RouteInformation(
      location: configuration.location,
    );
  }
}
