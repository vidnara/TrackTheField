import 'package:shotput/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackTheField',
      theme: myTheme,
    );
  }
}

void main() async {
  await Hive.openBox('distances');
  await Hive.initFlutter();
  runApp(const MyApp());
}
