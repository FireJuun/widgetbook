import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/addons/common/common.dart';
import 'package:widgetbook/src/state/state.dart';

import 'extensions/widget_tester_extension.dart';

Future<void> testAddon({
  required WidgetTester tester,
  required WidgetbookAddOn addon,
  required void Function(BuildContext context) expect,
  Future<void> Function()? act,
}) async {
  const key = ValueKey('RandomKey');

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: '/',
        builder: (context, state) {
          return WidgetbookScope(
            state: WidgetbookState(
              path: state.queryParams['path'] ?? '',
              previewMode: false,
              queryParams: {...state.queryParams}, // Copy from UnmodifiableMap
              addons: [addon],
              appBuilder: materialAppBuilder,
              catalog: WidgetbookCatalog.fromDirectories([]),
            ),
            child: Scaffold(
              // Simulates the approximate width of the panel.
              // It's also required to make some tests work
              // (not totally clear why).
              body: SizedBox(
                width: 500,
                child: Builder(
                  key: key,
                  builder: (context) {
                    return addon.buildSetting(context);
                  },
                ),
              ),
            ),
          );
        },
      )
    ],
  );

  await tester.pumpWidget(
    MaterialApp.router(
      routerConfig: router,
    ),
  );

  await act?.call();
  await tester.pumpAndSettle();

  final context = tester.findContextByKey(key);
  expect(context);
}
