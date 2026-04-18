import 'package:flutter/material.dart';
import 'home_screen.dart';
void main() {
  runApp(const TodoApp());
}
class TodoApp extends StatelessWidget{
  const TodoApp({super.key});
  @override
  Widget build(BuildContext){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
