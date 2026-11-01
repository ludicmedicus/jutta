import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LeftHandNotifier with ChangeNotifier {
  bool _isLeft = false;

  LeftHandNotifier(){
    _loadLeftHand();
  }
  Future<void> _loadLeftHand() async {
    final prefs = await SharedPreferences.getInstance();
    _isLeft = prefs.getBool('isLeftHanded') ?? false;
    
    notifyListeners();
  }

  bool get isLeft => _isLeft;

  Future<void> setLeftRight(bool lhstat) async {

    _isLeft = lhstat;
    notifyListeners();
  }
}