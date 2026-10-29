import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './my_button.dart';

class EditTimer extends StatefulWidget {
  const EditTimer({super.key});

  @override
  State<EditTimer> createState() => _EditTimerState();
}

class _EditTimerState extends State<EditTimer>{
  late TextEditingController myController;
  int _userTime = 0;
  int _lastUserTime = 0;
  bool _isKeyboard = false;

@override
  void initState() {
    super.initState();
    _loadTime();
  }

  Future<void> _loadTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() { //find out how to get value of keyboard val to change when reloading or clearing time
      _userTime = prefs.getInt('userTime') ?? 0;
      _lastUserTime = prefs.getInt('lastUserTime') ?? 0;
      _isKeyboard = prefs.getBool('isKeyboard') ?? false;
    myController = TextEditingController(text: _userTime.toString());
    });
  }
    Future<void> _incrementTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userTime = (prefs.getInt('userTime') ?? 0);
      _userTime = _userTime + 1;
      prefs.setInt('userTime', _userTime);
    });
  }

    Future<void> _decrementTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userTime = (prefs.getInt('userTime') ?? 0);
      _userTime = ((_userTime > 0) ? _userTime - 1 : 0);
      prefs.setInt('userTime', _userTime);
    });
  }

  Future<void> _resetTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userTime = 0;
      prefs.setInt('userTime', _userTime);
    });
  }
  Future<void> _useLastTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userTime = _lastUserTime;
      prefs.setInt('userTime', _userTime);
    });
    myController.text = _userTime.toString();
  }
  Future<void> _clearTimer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userTime = 0;
      _lastUserTime = 0;
      prefs.setInt('userTime', _userTime);
      prefs.setInt('lastUserTime', _lastUserTime);
    });
    myController.text = _userTime.toString();
  }
  Future<void> _setInputSettings() async {
    final prefs = await SharedPreferences.getInstance();
    //bad idea
    myController.text = _userTime.toString();
    setState(() {
      _isKeyboard = !_isKeyboard;
       prefs.setBool('isKeyboard', _isKeyboard);
    });
  }



  Future<void> _setTimeKB() async {
    final prefs = await SharedPreferences.getInstance();
    final text = myController.text;
    setState(() {
      _userTime = (prefs.getInt('userTime') ?? 0);
      _userTime = (text.isNotEmpty) ? int.parse(text) : 0;
       prefs.setInt('userTime', _userTime);
    });
  }


  Future<void> _navigateToPage(BuildContext context, String pathName) async {
    final prefs = await SharedPreferences.getInstance();
    myController.clear();
    setState(() {

      _lastUserTime = _userTime;
      prefs.setInt('lastUserTime', _lastUserTime);
      prefs.setBool('isKeyboard', _isKeyboard);
    });
    final result = await Navigator.pushNamed(
      context,
      pathName
    );
    
   }
late var timerButtons = {
MyButton(onPressed: _incrementTimer, icon: const Icon(Icons.add)),
MyButton(onPressed: _resetTimer, icon: const Icon(Icons.exposure_zero)),
MyButton(onPressed: _decrementTimer, icon: const Icon(Icons.remove)),

  };
late var settingsButtons = {
MyButton(onPressed: _useLastTimer, icon: const Icon(Icons.history)),
MyButton(onPressed: _clearTimer, icon: const Icon(Icons.cleaning_services_sharp)),
MyButton(onPressed: 
        () {_navigateToPage(context, '/settings');}, icon: const Icon(Icons.settings)),


  };

@override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Edit Timer")),
      body: Center(
        
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            (!_isKeyboard) ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_userTime',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
for(var b in timerButtons) b,
            
          ],
        ) :
Padding(
  padding: const EdgeInsets.all(8),
  child: Column(
    
    children: <Widget>[SizedBox(
      width: 100,
      child: TextField(
        controller: myController,
        onChanged:(value) async {
          _setTimeKB();
        },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
                   FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp('^0+'))
                 ],
          ),),],)), 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            (_isKeyboard) ? MyButton(onPressed:_setInputSettings, icon: const Icon(Icons.touch_app)) : MyButton(onPressed:_setInputSettings, icon: const Icon(Icons.dialpad)),
            
          ],
        ),
            Container(
              child: (_userTime == 0) ? Container() : MyButton(onPressed: 
        () {_navigateToPage(context,'/timer');}, icon: const Icon(Icons.send))),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
             for (var b in settingsButtons) (b),
            
          ],
        ),
          ]),
      ),

    );
  }

}