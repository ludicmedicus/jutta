import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './my_button.dart';

class MainTimer extends StatefulWidget {
  const MainTimer({super.key});

  @override
  State<MainTimer> createState() => _MainTimerState();
}

class _MainTimerState extends State<MainTimer>{
  int _userTime = 0;
  int _timeRemaining = 0;
  int _totalTimeSpent = 0;
  late Timer _myTimer;
  bool _isRunning = false;
@override
  void initState() {
    super.initState();
    _loadTime();
  }
  Future<void> _loadTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userTime = prefs.getInt('userTime') ?? 0;
      _timeRemaining = _userTime * 60;
      _isRunning = false;
      _totalTimeSpent = prefs.getInt('totalTimeSpent') ?? 0;
    });
_runTimer();
  }

Future<void> _runTimer() async {
  setState(() {
      _isRunning = true;
    });
_myTimer = Timer.periodic(Duration(seconds: 1), (timer){
  setState(() {
    if(_timeRemaining > 0){
      _timeRemaining--;
      _totalTimeSpent++;
    }else{
      _isRunning = false;
        _myTimer.cancel();
      }
    });
  
});
}
Future<void> _stopTimer() async {
  
    final prefs = await SharedPreferences.getInstance();
  setState(() {
      _isRunning = false;
      prefs.setInt('totalTimeSpent', _totalTimeSpent);
    });
    _myTimer.cancel();
 
}
Future<void> _resetTimer() async {
  setState(() {
      _timeRemaining = _userTime*60;
    });
    _myTimer.cancel();
 
}

String formatTimer(int t){
double hrs_raw = t/3600;
int hrs_whole = t~/3600;
double t_minSec = (hrs_raw - hrs_whole) * 3600;
int min = (t_minSec/60).floor();
int sec = (t_minSec%60).floor();

String h = (hrs_whole).toString().padLeft(2, '0');
String m = (min).toString().padLeft(2, '0');
String s = (sec).toString().padLeft(2, '0');

return '$h : $m : $s';
}


   Future<void> _navigateToPage(BuildContext context, String routeName) async {
    
    final result = await Navigator.pushNamed(
      context,
      routeName);
   }
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Time remaining: ',
              style: Theme.of(context).textTheme.headlineMedium,),
            Text(formatTimer(_timeRemaining),
              style: Theme.of(context).textTheme.headlineMedium,),
_isRunning ? Container() : MyButton(onPressed: 
        () {_navigateToPage(context, '/edit');}, icon: const Icon(Icons.edit)),
(_userTime != 0 || _isRunning) ? MyButton(onPressed: _isRunning ? _stopTimer : _runTimer, icon: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow)) : Container(),
_isRunning ? Container() : MyButton(onPressed: _resetTimer, icon: const Icon(Icons.replay)),
MyButton(onPressed: 
        () {_navigateToPage(context, '/settings');}, icon: const Icon(Icons.settings)),
            
          ],
        );
  }

}