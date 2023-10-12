import 'package:autojidelna/every_import.dart';

class Themes {
  //theme
  static ThemeData getTheme(ColorScheme colorScheme) {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _dark = false;
    if (colorScheme.brightness == Brightness.dark) {
      _dark = true;
    }
    return ThemeData(
      useMaterial3: true,
      applyElevationOverlayColor: true,
      inputDecorationTheme: const InputDecorationTheme(
        alignLabelWithHint: true,
        isDense: true,
        isCollapsed: true,
        errorMaxLines: 1,
        labelStyle: TextStyle(),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintStyle: TextStyle(),
        helperStyle: TextStyle(),
      ),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      scrollbarTheme: const ScrollbarThemeData(),
      splashFactory: NoSplash.splashFactory,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      canvasColor: colorScheme.background,
      colorScheme: colorScheme,
      disabledColor: colorScheme.surfaceVariant,
      scaffoldBackgroundColor: colorScheme.background,
      shadowColor: Colors.transparent,
      splashColor: Colors.transparent,
      iconTheme: IconThemeData(
        size: 30,
        color: colorScheme.onBackground,
      ),
      typography: Typography.material2021(),
      appBarTheme: AppBarTheme(
        elevation: 2,
        backgroundColor: _dark ? colorScheme.background : colorScheme.primary,
        foregroundColor: _dark ? colorScheme.onBackground : colorScheme.onPrimary,
        iconTheme: IconThemeData(
          color: _dark ? colorScheme.onBackground : colorScheme.onPrimary,
        ),
        actionsIconTheme: IconThemeData(
          color: _dark ? colorScheme.onBackground : colorScheme.onPrimary,
        ),
      ),
      cardTheme: const CardTheme(elevation: 2),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colorScheme.background,
        headerBackgroundColor: _dark ? colorScheme.onBackground.withOpacity(0.1) : colorScheme.secondary,
        headerForegroundColor: _dark ? colorScheme.onBackground : colorScheme.onSecondary,
        dividerColor: Colors.transparent,
        elevation: 0,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.background,
        elevation: 1,
        surfaceTintColor: colorScheme.surfaceTint,
        alignment: Alignment.center,
        iconColor: colorScheme.onBackground,
        titleTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(
          fontSize: 15,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 7),
      ),
      dividerTheme: DividerThemeData(color: colorScheme.surfaceVariant),
      drawerTheme: DrawerThemeData(
        surfaceTintColor: colorScheme.surfaceTint,
        backgroundColor: colorScheme.background,
        scrimColor: colorScheme.scrim,
        elevation: 2,
        width: 275,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return colorScheme.surfaceVariant; // Disabled color
            }
            return colorScheme.background; // Regular color
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return colorScheme.onSurfaceVariant;
            }
            return colorScheme.onBackground;
          }),
          fixedSize: const MaterialStatePropertyAll(Size.fromHeight(50)),
          splashFactory: InkRipple.splashFactory,
          alignment: Alignment.center,
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          elevation: const MaterialStatePropertyAll(4),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        collapsedTextColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
        childrenPadding: const EdgeInsets.only(bottom: 8),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      listTileTheme: ListTileThemeData(
        dense: false,
        selectedColor: colorScheme.primary,
        iconColor: colorScheme.onBackground,
        textColor: colorScheme.onBackground,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        subtitleTextStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        visualDensity: VisualDensity.comfortable,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        elevation: 2,
        contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        showCloseIcon: true,
        closeIconColor: colorScheme.onInverseSurface,
      ),
      switchTheme: const SwitchThemeData(splashRadius: 0),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(colorScheme.onSurface),
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
          ),
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return colorScheme.primary;
              }
              return Colors.transparent;
            },
          ),
        ),
      ),
    );
  }
}

class ColorSchemes {
  final ColorScheme light = const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.purpleAccent,
    onPrimary: Colors.white,
    secondary: Color(0x7B009687),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceVariant: Colors.black12,
    onSurfaceVariant: Colors.black54,
    scrim: Colors.black54,
    surfaceTint: Colors.black,
    inverseSurface: Color(0xFF121212),
    onInverseSurface: Colors.white,
  );

  final ColorScheme dark = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffbb86fc),
    onPrimary: Colors.white,
    secondary: Color(0xff018786),
    onSecondary: Colors.white,
    error: Color(0xFFCF6679),
    onError: Colors.white,
    background: Color(0xff121212),
    onBackground: Colors.white,
    surface: Color(0xff121212),
    onSurface: Colors.white,
    surfaceVariant: Colors.white12,
    onSurfaceVariant: Colors.white54,
    scrim: Colors.black54,
    surfaceTint: Colors.white,
    inverseSurface: Color(0xFFdddddd),
    onInverseSurface: Colors.black,
  );
}