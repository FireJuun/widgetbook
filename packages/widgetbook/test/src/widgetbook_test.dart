import 'package:flutter/material.dart' hide RouterDelegate;
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/routing/route_parser.dart';
import 'package:widgetbook/src/routing/router_delegate.dart';
import 'package:widgetbook/widgetbook.dart';

Matcher expectAssertionErrorWithMessage({
  required String message,
}) {
  return throwsA(
    allOf(
      isA<AssertionError>(),
      predicate(
        (AssertionError e) => e.message == message,
      ),
    ),
  );
}

Router<Object> _getRouter() {
  return Router(
    routeInformationParser: RouteParser(),
    routerDelegate: RouterDelegate(),
  );
}

Widget _defaultAppBuilderMethod(BuildContext context, Widget child) {
  final router = _getRouter();
  return WidgetsApp.router(
    color: Colors.transparent,
    debugShowCheckedModeBanner: false,
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
    builder: (context, childWidget) {
      return childWidget ?? child;
    },
  );
}

void main() {
  group(
    '$Widgetbook',
    () {
      group(
        'constructor throws $AssertionError when',
        () {
          test(
            'textScaleFactors is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    TextScaleAddon(
                      scales: [],
                    )
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'scales cannot be empty',
                ),
              );
            },
          );

          test(
            'themes is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    MaterialThemeAddon(
                      themes: const [],
                    ),
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'themes cannot be empty',
                ),
              );
            },
          );

          test(
            'devices is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    DeviceAddon(
                      devices: [],
                    ),
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'devices cannot be empty',
                ),
              );
            },
          );

          test(
            'supportedLocales is empty',
            () {
              expect(
                () => Widgetbook<ThemeData>(
                  appBuilder: _defaultAppBuilderMethod,
                  addons: [
                    LocalizationAddon(
                      locales: [],
                      localizationsDelegates: [],
                    ),
                  ],
                ),
                expectAssertionErrorWithMessage(
                  message: 'locales cannot be empty',
                ),
              );
            },
          );
        },
      );
    },
  );
}
