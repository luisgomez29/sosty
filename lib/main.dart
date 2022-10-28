import 'package:sosty/push_notifications.dart';
import 'package:flutter/material.dart';
import 'package:sosty/app.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await Notifications.init();
  runApp(const App());
}
