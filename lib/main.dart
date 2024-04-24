import 'package:apiexam/presentation/homescreen/controller/homescreen_controller.dart';
import 'package:apiexam/presentation/homescreen/view/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomescreenController())
        ],
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: Homescreen()));
  }
}
