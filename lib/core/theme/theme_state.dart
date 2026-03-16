import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});

  factory ThemeState.initial() {
    return ThemeState(themeMode: ThemeMode.system);
  }

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
