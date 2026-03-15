import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final CacheHelper _cacheHelper;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this._cacheHelper) : super(ThemeState.initial()) {
    _loadTheme();
  }

  void _loadTheme() {
    final String? themeMode = _cacheHelper.getData(key: _themeKey);
    if (themeMode != null) {
      if (themeMode == 'dark') {
        emit(state.copyWith(themeMode: ThemeMode.dark));
      } else if (themeMode == 'light') {
        emit(state.copyWith(themeMode: ThemeMode.light));
      } else {
        emit(state.copyWith(themeMode: ThemeMode.system));
      }
    }
  }

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      _setTheme(ThemeMode.dark);
    } else {
      _setTheme(ThemeMode.light);
    }
  }

  void _setTheme(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
    String themeString;
    switch (themeMode) {
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }
    _cacheHelper.saveData(key: _themeKey, value: themeString);
  }
}
