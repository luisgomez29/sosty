import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosty/app/push_notifications.dart';
import 'package:flutter/material.dart';
import 'package:sosty/app/app.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Notifications.init();
  runApp(const ProviderScope(child: App()));
}
