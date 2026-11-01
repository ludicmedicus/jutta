import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import './timer_themes.dart';
import './theme_notifier.dart';
import './my_button.dart';

class ThemeProvider extends StatefulWidget {
  
  const ThemeProvider({super.key});

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}
class _ThemeProviderState extends State<ThemeProvider> {
  ThemeMode _currentThemeMode = ThemeMode.light;
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentThemeMode = ThemeMode.values.byName(prefs.getString('themeMode') ?? "light");
    });
  }
    Future<void> _setSelectedThemeMode(ThemeMode mode, ThemeModeNotifier themeModeNotifier) async {
    final prefs = await SharedPreferences.getInstance();
    themeModeNotifier.setThemeMode(mode);
    setState(() {
      _currentThemeMode = mode;
    prefs.setString('themeMode', _currentThemeMode.name);
    });
  }

    @override
  Widget build(BuildContext context) {
    final themeModeNotifier = Provider.of<ThemeModeNotifier>(context);
    setState(() {
      _currentThemeMode = themeModeNotifier.getThemeMode();
    });
  return SizedBox(
      width: 69,
          child: 
              (_currentThemeMode.name == "light" || _currentThemeMode.name == "system" ) ? MyButton(onPressed: (){_setSelectedThemeMode(ThemeMode.dark, themeModeNotifier);}, icon: const Icon(Icons.nightlight_round_outlined)):
              MyButton(onPressed: (){_setSelectedThemeMode(ThemeMode.light, themeModeNotifier);}, icon: const Icon(Icons.sunny)),

        );
  }
}