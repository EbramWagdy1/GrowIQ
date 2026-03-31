import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final CacheHelper _cacheHelper;
  static const String _localeKey = 'locale';

  LocaleCubit(this._cacheHelper) : super(LocaleState.initial()) {
    _loadLocale();
  }

  void _loadLocale() {
    final String? localeCode = _cacheHelper.getData(key: _localeKey);
    if (localeCode != null) {
      emit(state.copyWith(locale: Locale(localeCode)));
    }
  }

  void changeLocale(String localeCode) async {
    _cacheHelper.saveData(key: _localeKey, value: localeCode);
    emit(state.copyWith(locale: Locale(localeCode)));

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(user.uid)
            .child('language')
            .set(localeCode);
      } catch (e) {
        debugPrint("Error syncing language to Firebase: $e");
      }
    }
  }
}
