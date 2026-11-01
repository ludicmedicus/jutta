import 'package:flutter/material.dart';
import './timer_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import './theme_notifier.dart';
import './left_hand_notifier.dart';
import './settings_timer.dart';
import './my_button.dart';
import './main_timer.dart';
import './edit_timer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
SharedPreferences.getInstance().then((prefs) {
    
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<ThemeModeNotifier>(
        create: (_) =>
            ThemeModeNotifier(),),
        ChangeNotifierProvider<LeftHandNotifier>(
        create: (_) =>
            LeftHandNotifier(),),
      ],
        child: MyApp(),
      ),
    );
  });
}
class MyApp extends StatelessWidget {
    const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);
    
    return MaterialApp(
      title: 'Flutter Demo',
       debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.getThemeMode(),
      initialRoute: '/edit',
      routes:{
        '/': (context) => const MyHomePage(),
        '/timer': (context) => const MainTimer(),
        '/edit': (context) => const EditTimer(),
        '/settings': (context) => const SettingsTimer(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

   Future<void> _navigateToTimer(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,'/edit'
    );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer'),
      leading: IconButton(
        icon: const Icon (Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),),
      body:  Center(child: MyButton(onPressed: () {_navigateToTimer(context);}, icon: const Icon(Icons.access_time)),),
    );
  }
 }


