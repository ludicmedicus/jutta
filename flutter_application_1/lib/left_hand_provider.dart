import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import './left_hand_notifier.dart';
import './my_button.dart';

class LeftHandProvider extends StatefulWidget {
  
  const LeftHandProvider({super.key});

  @override
  State<LeftHandProvider> createState() => _LeftHandProviderState();
}
class _LeftHandProviderState extends State<LeftHandProvider> {
  bool _isLeft = false;
  @override
  void initState() {
    super.initState();
    _loadLeftHand();
  }
Future<void> _loadLeftHand() async {
    final prefs = await SharedPreferences.getInstance();
    _isLeft = prefs.getBool('isLeftHanded') ?? false;
    
  }
    Future<void> _setLeftRight(bool lhStatus, LeftHandNotifier lhNote) async {
    final prefs = await SharedPreferences.getInstance();
    lhNote.setLeftRight(lhStatus);
    setState(() {
      _isLeft = lhStatus;
    prefs.setBool('isLeftHand', _isLeft);
    });
  }

    @override
  Widget build(BuildContext context) {
    final leftHandNotifier = Provider.of<LeftHandNotifier>(context);
    setState(() {
      _isLeft = leftHandNotifier.isLeft;
    });
  return SizedBox(
      width: 69,
          child: 
              _isLeft ? MyButton(onPressed: (){_setLeftRight(false, leftHandNotifier);}, icon: const Icon(Icons.front_hand)): 
        MyButton(onPressed: (){_setLeftRight(true, leftHandNotifier);}, icon: const Icon(Icons.back_hand)),

        );
  }
}