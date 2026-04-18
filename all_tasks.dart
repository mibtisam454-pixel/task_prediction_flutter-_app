import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
class AllTasksScreen extends StatefulWidget {
  @override
  AllTasksScreenState createState() => AllTasksScreenState();
}

class AllTasksScreenState extends State<AllTasksScreen> {
  List<Task> tasks = [
    Task(title: "Design meeting", time: "12:23 PM", notes: ""),
    Task(title: "Hhhh", time: "12:28 PM", notes: ""),
    Task(title: "Tour to Lahore", time: "11:54 AM", notes: "With friends"),
    Task(title: "Adddddd", time: "1:36 PM", notes: ""),
    Task(title: "New Project", time: "1:43 PM", notes: "Meeting about the project"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Text(
                "All Tasks",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [

                          SlidableAction(
                            onPressed: (context) {
                              print("Edit ${task.title}");
                            },
                            backgroundColor: Colors.blue,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),

                          SlidableAction(
                            onPressed: (context) {
                              setState(() {
                                tasks.removeAt(index);
                              });
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),

                        ],
                      ),

                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            task.isDone = !task.isDone;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xffE8DAF1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              task.isDone
                                  ? CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.purple,
                                child: Icon(Icons.check,
                                    color: Colors.white, size: 10),
                              )
                                  : Icon(
                                Icons.radio_button_unchecked,
                                size: 28,
                                color: Colors.grey,
                              ),

                              SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          task.title,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          task.time,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "Notes:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            task.notes,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Task {
  final String title;
  final String time;
  final String notes;
  bool isDone;

  Task({
    required this.title,
    required this.time,
    required this.notes,
    this.isDone = false,
  });
}