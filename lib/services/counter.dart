import 'package:shared_preferences/shared_preferences.dart';

class Counter {


  Future<int> getMaxValueOfCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('counter') ?? 0;
    return counter;
  }

  Future<void> setMaxValueOfCounter(counter) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
  }
}

