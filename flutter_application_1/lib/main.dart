import 'package:flutter/material.dart';
import './settings_timer.dart';
import './my_button.dart';
import './main_timer.dart';
import './edit_timer.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
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
      context,'/timer'
    );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer Demo')),
      body:  Center(child: MyButton(onPressed: () {_navigateToTimer(context);}, icon: const Icon(Icons.punch_clock)),),
    );
  }
 }


