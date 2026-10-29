import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './my_button.dart';

class SettingsTimer extends StatefulWidget {
  const SettingsTimer({super.key});

  @override
  State<SettingsTimer> createState() => _SettingsTimerState();
}

class _SettingsTimerState extends State<SettingsTimer>{
  int _totalTimeSpent = 0;
  int _currentStreak = 0;
  int _maxStreak = 0;
  int _lastUserTime = 0;
  bool _isDay = true;
  //add color enums??
@override
  void initState() {
    super.initState();
    _loadTime();
  }
  Future<void> _loadTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastUserTime = prefs.getInt('lastUserTime') ?? 0;
      _totalTimeSpent = prefs.getInt('totalTimeSpent') ?? 0;
      _isDay = prefs.getBool('isDay') ?? true;
    });
  }
  
  Future<void> _clearTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastUserTime = 0;
      prefs.setInt('lastUserTime', _lastUserTime);
    });
  }
   Future<void> _setDayNight() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDay = !_isDay;
      prefs.setBool('isDay', _isDay);
    });
   }
late var settingsButtons = {
MyButton(onPressed: _clearTimer, icon: const Icon(Icons.cleaning_services_sharp)),

  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timer Settings")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Last Time: $_lastUserTime',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Total Time: $_totalTimeSpent',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Longest Streak: $_maxStreak',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Current Streak: $_currentStreak',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            for (var b in settingsButtons) (b),
            _isDay ? MyButton(onPressed: 
        _setDayNight, icon: const Icon(Icons.mode_night)) : MyButton(onPressed: 
        _setDayNight, icon: const Icon(Icons.sunny)),
            
          ],
        )

          ]),
      ),

    );
  }
  }

