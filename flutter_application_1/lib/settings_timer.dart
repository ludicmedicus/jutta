import 'package:flutter/material.dart';
import 'package:flutter_application_1/left_hand_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './my_button.dart';
import './theme_provider.dart';
import './left_hand_provider.dart';
import 'package:provider/provider.dart';

class SettingsTimer extends StatefulWidget {
  const SettingsTimer({super.key});

  @override
  State<SettingsTimer> createState() => _SettingsTimerState();
}

class _SettingsTimerState extends State<SettingsTimer>{
  int _totalTimeSpent = 0;
  int _completedSessions = 0;
  int _lastUserTime = 0;
  bool _isKeyboard = false;
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
      _completedSessions = prefs.getInt('completedSessions') ?? 0;
      _isKeyboard = prefs.getBool('isKeyboard') ?? false;
    });
  }
  
  Future<void> _clearStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastUserTime = 0;
      _totalTimeSpent = 0;
      _completedSessions = 0;
      prefs.setInt('lastUserTime', _lastUserTime);
      prefs.setInt('totalTimeSpent', _totalTimeSpent);
      prefs.setInt('completedSessions', _completedSessions);
    });//have option to clear all stats too
  }
   String formatTimer(int t){
double hrs_raw = t/3600;
int hrs_whole = t~/3600;
double t_minSec = (hrs_raw - hrs_whole) * 3600;
int min = (t_minSec/60).floor();
int sec = (t_minSec%60).floor();

String h = (hrs_whole).toString();
String m = (min).toString();
String s = (sec).toString();

return '${(hrs_whole > 0) ? '$h hrs, ' : ""} ${(min > 0) ? '$m mins, ' : ""} $s secs';
}
late var settingsButtons = {//also include a left hand mode and a go back button?
MyButton(onPressed: _clearStats, icon: const Icon(Icons.cleaning_services_sharp)),

  };

  @override
  Widget build(BuildContext context) {
    final leftHandNotifier = Provider.of<LeftHandNotifier>(context);
    double widthBox = MediaQuery.sizeOf(context).width;
    double heightBox = MediaQuery.sizeOf(context).height;
    
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),
      leading: IconButton(
        icon: const Icon (Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),),
      body: 
      SizedBox(
        height: heightBox,
        width: widthBox,
        child: Stack(
          children: <Widget>[
            Positioned(
              top:heightBox/3,
              left:2*widthBox/5,
              child:
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Statistics:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Last Timer: $_lastUserTime ${(_lastUserTime > 1) ? "minutes" : "minute"}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Total Time: ${formatTimer(_totalTimeSpent)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Completed Sessions: $_completedSessions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            
          ],
        )),
        Positioned(
              top:2*heightBox/5,
              left: (leftHandNotifier.isLeft) ? 34*widthBox/100 : 3*widthBox/5,
              child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            for (var b in settingsButtons) (b),
            
        LeftHandProvider(),
        ThemeProvider(),
            
          ],
        ))

          ]),
      ),

    );
  }
  }

