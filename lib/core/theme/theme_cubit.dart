import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'app_thems.dart';
import 'package:injectable/injectable.dart';

@injectable
class ThemeCubit extends HydratedCubit<ThemeData> {
  ThemeCubit() : super(AppTheme.themes[AppThemeColor.purple]!);

  void changeTheme(AppThemeColor themeColor) {
    emit(AppTheme.themes[themeColor]!);
  }

  @override
  ThemeData fromJson(Map<String, dynamic> json) {
    final index = json['theme'];
    return AppTheme.themes.values.toList()[index];
  }

  @override
  Map<String, dynamic> toJson(ThemeData state) {
    final index = AppTheme.themes.values.toList().indexOf(state);
    return {'theme': index};
  }
}
