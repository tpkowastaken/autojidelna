import 'package:autojidelna/classes_enums/all.dart';
import 'package:autojidelna/shared_prefs.dart';
import 'package:flutter/material.dart';

/// Manages user preferences related to UI settings.
///
/// [themeStyle]            | Colorscheme of the app
///
/// [themeMode]             | Theme mode of the app
///
/// [isListUi]              | If true, Canteen menu is displayed in a list
///
/// [isPureBlack]           | If true, dark mode joins the dark side of the force
///
/// [bigCalendarMarkers]    | If true,  displays big markers in calendar
///
/// [skipWeekends]          | If true, doesnt display or skips weekends in Canteen menu
class UserPreferences with ChangeNotifier {
  ThemeStyle _themeStyle = ThemeStyle.defaultStyle;
  ThemeMode _themeMode = ThemeMode.system;
  bool _isListUi = false;
  bool _isPureBlack = false;
  bool _bigCalendarMarkers = false;
  bool _skipWeekends = false;

  /// Theme style getter
  ThemeStyle get themeStyle => _themeStyle;

  /// Theme mode getter
  ThemeMode get themeMode => _themeMode;

  /// List UI getter
  bool get isListUi => _isListUi;

  /// Pure black getter
  bool get isPureBlack => _isPureBlack;

  /// Big calendar markers getter
  bool get bigCalendarMarkers => _bigCalendarMarkers;

  /// Skip weekends getter
  bool get skipWeekends => _skipWeekends;

  void setAll({
    ThemeStyle? themeStyle,
    ThemeMode? themeMode,
    bool? isListUi,
    bool? isPureBlack,
    bool? bigCalendarMarkers,
    bool? skipWeekends,
  }) {
    _themeStyle = themeStyle ?? _themeStyle;
    _themeMode = themeMode ?? _themeMode;
    _isListUi = isListUi ?? _isListUi;
    _isPureBlack = isPureBlack ?? _isPureBlack;
    _bigCalendarMarkers = bigCalendarMarkers ?? _bigCalendarMarkers;
    _skipWeekends = skipWeekends ?? _skipWeekends;
    notifyListeners();
  }

  /// Setter for theme style
  set setThemeStyle(ThemeStyle themeStyle) {
    if (_themeStyle == themeStyle) return;
    _themeStyle = themeStyle;
    saveStringToSharedPreferences(Keys.themeStyle, _themeStyle.toString());
    notifyListeners();
  }

  /// Setter for theme mode
  set setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    saveStringToSharedPreferences(Keys.themeMode, _themeMode.toString());
    notifyListeners();
  }

  /// Setter for list UI
  set setListUi(bool isListUi) {
    _isListUi = isListUi;
    saveBoolToSharedPreferences(Keys.listUi, _isListUi);
    notifyListeners();
  }

  /// Setter for pure black
  set setPureBlack(bool isPureBlack) {
    _isPureBlack = isPureBlack;
    saveBoolToSharedPreferences(Keys.pureBlack, _isPureBlack);
    notifyListeners();
  }

  /// Setter for big calendar markers
  set setCalendarMarkers(bool bigCalendarMarkers) {
    _bigCalendarMarkers = bigCalendarMarkers;
    saveBoolToSharedPreferences(Keys.bigCalendarMarkers, _bigCalendarMarkers);
    notifyListeners();
  }

  /// Setter for skip weekends
  set setSkipWeekends(bool skipWeekends) {
    _skipWeekends = skipWeekends;
    saveBoolToSharedPreferences(Keys.skipWeekends, _skipWeekends);
    notifyListeners();
  }
}

class NotificationPreferences with ChangeNotifier {
  bool _todaysFood = false;
  TimeOfDay _sendTodaysFood = const TimeOfDay(hour: 11, minute: 0);
  bool _lowCredit = false;
  bool _weekLongFamine = false;

  bool get todaysFood => _todaysFood;
  TimeOfDay get sendTodaysFood => _sendTodaysFood;
  bool get lowCredit => _lowCredit;
  bool get weekLongFamine => _weekLongFamine;

  void setAll({
    bool? todaysFood,
    TimeOfDay? sendTodaysFood,
    bool? lowCredit,
    bool? weekLongFamine,
  }) {
    _todaysFood = todaysFood ?? _todaysFood;
    _sendTodaysFood = sendTodaysFood ?? _sendTodaysFood;
    _lowCredit = lowCredit ?? _lowCredit;
    _weekLongFamine = weekLongFamine ?? _weekLongFamine;
  }

  set setTodaysFood(bool todaysFood) {
    _todaysFood = todaysFood;
    saveBoolToSharedPreferences(Keys.todaysFood, _todaysFood);
    notifyListeners();
  }

  set setSendTodaysFood(TimeOfDay sendTodaysFood) {
    _sendTodaysFood = sendTodaysFood;
    saveStringToSharedPreferences(Keys.sendTodaysFood, _sendTodaysFood.toString());
    notifyListeners();
  }

  set setLowCredit(bool lowCredit) {
    _lowCredit = lowCredit;
    saveBoolToSharedPreferences(Keys.lowCredit, _lowCredit);
    notifyListeners();
  }

  set setWeekLongFamine(bool weekLongFamine) {
    _weekLongFamine = weekLongFamine;
    saveBoolToSharedPreferences(Keys.weekLongFamine, _weekLongFamine);
    notifyListeners();
  }
}