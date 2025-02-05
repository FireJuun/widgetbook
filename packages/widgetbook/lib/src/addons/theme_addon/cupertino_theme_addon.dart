import 'package:flutter/cupertino.dart';

import 'theme_addon.dart';
import 'widgetbook_theme.dart';

class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
    WidgetbookTheme<CupertinoThemeData>? initialTheme,
  }) : super(
          themes: themes,
          initialTheme: initialTheme,
          themeBuilder: (context, theme, child) {
            return CupertinoTheme(
              data: theme,
              child: child,
            );
          },
        );
}
