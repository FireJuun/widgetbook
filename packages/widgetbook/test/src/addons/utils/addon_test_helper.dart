import 'package:flutter/material.dart' hide RouterDelegate;
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/addons.dart';
import 'package:widgetbook/src/routing/route_parser.dart';
import 'package:widgetbook/src/routing/router_delegate.dart';
import 'package:widgetbook/src/state/state.dart';

import 'extensions/widget_tester_extension.dart';

Future<void> testAddon({
  required WidgetTester tester,
  required WidgetbookAddOn addon,
  required void Function(BuildContext context) expect,
  Future<void> Function()? act,
}) async {
  const key = ValueKey('RandomKey');

  final router = Router(
    key: key,
    routeInformationParser: RouteParser(),
    routerDelegate: RouterDelegate(
      addons: [addon],
      appBuilder: materialAppBuilder,
      catalog: WidgetbookCatalog.fromDirectories([]),
    ),
  );

  await tester.pumpWidget(
    MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    ),
  );

  await act?.call();
  await tester.pumpAndSettle();

  final context = tester.findContextByKey(key);
  expect(context);
}
