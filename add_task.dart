import 'package:flutter/cupertino(1).dart';
import 'package:flutter/material(1).dart';

class addtask extends StatelessWidget{ 
  @override 
  Widget build(BuildContext) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Add Task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)
          ],
        ),
      ),
    );
  }
}