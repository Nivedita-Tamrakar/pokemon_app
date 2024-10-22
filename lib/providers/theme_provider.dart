import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends StateNotifier<bool> {
  ThemeProvider()
      : super(
            false); // we are crrating a constructor and initializing with super constructor with false initial value
  Future toggleTheme() async
 {
  final SharedPreferencesAsync ayncPref = SharedPreferencesAsync();
    state = !state; // current state
    await ayncPref.setBool('theme', state);
  }

  Future getSavedTheme() async {
    final SharedPreferencesAsync asyncPref = SharedPreferencesAsync();
    final bool? savedTheme = await asyncPref.getBool('theme');
    state = savedTheme ?? false;
  }
}

final themeProvider =
    StateNotifierProvider<ThemeProvider, bool>((ref) => ThemeProvider());
