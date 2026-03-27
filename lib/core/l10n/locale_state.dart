import 'package:flutter/material.dart';

class LocaleState {
  final Locale? locale;

  LocaleState(this.locale);

  factory LocaleState.initial() {
    return LocaleState(null);
  }

  LocaleState copyWith({Locale? locale}) {
    return LocaleState(locale ?? this.locale);
  }
}
