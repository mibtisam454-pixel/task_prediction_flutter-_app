import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  Map<String, List<String>> tasks = {
    "2026-06-12": ["Work"],
    "2026-06-13": ["Personal"],
    "2026-06-14": ["Health"],
    "2026-07-01": ["Shopping"],

  };


  String _formatDate(DateTime day) {
    return "${day.year}-${day.month.toString().padLeft(2,'0')}-${day.day.toString().padLeft(2,'0')}";
  }


  List<String> _getTasksForDay(DateTime day) {
    return tasks[_formatDate(day)] ?? [];
  }


  void _addTask(String task) {
    if (_selectedDay == null) return;
    final key = _formatDate(_selectedDay!);
    setState(() {
      if (tasks.containsKey(key)) {
        tasks[key]!.add(task);
      } else {
        tasks[key] = [task];
      }
    });
  }


  void _deleteTask(int index) {
    if (_selectedDay == null) return;
    final key = _formatDate(_selectedDay!);
    setState(() {
      tasks[key]!.removeAt(index);
      if (tasks[key]!.isEmpty) tasks.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> selectedTasks =
    _selectedDay == null ? [] : _getTasksForDay(_selectedDay!);

    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) =>
            _selectedDay != null && _formatDate(day) == _formatDate(_selectedDay!),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            // Show dots for dates with tasks
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                final key = _formatDate(day);
                if (tasks.containsKey(key) && tasks[key]!.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _selectedDay == null
                      ? "Select a date"
                      : "Tasks for ${_formatDate(_selectedDay!)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (_selectedDay != null)
                IconButton(
                  icon: Icon(Icons.add, color: Colors.purple),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String newTask = "";
                        return AlertDialog(
                          title: Text("Add Task"),
                          content: TextField(
                            onChanged: (value) => newTask = value,
                            decoration: InputDecoration(hintText: "Task Name"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  if (newTask.trim().isNotEmpty) {
                                    _addTask(newTask.trim());
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text("Add")),
                          ],
                        );
                      },
                    );
                  },
                )
            ],
          ),

          Expanded(
            child: selectedTasks.isEmpty
                ? Center(child: Text("No tasks"))
                : ListView.builder(
              itemCount: selectedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.purple),
                  title: Text(selectedTasks[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}