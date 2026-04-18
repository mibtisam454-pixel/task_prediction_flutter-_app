import 'package:flutter/material.dart';
import 'all_tasks.dart';
class CalenderMonthScreen extends StatefulWidget {
  @override
  _CalenderMonthScreenState createState() => _CalenderMonthScreenState();
}
class _CalenderMonthScreenState extends State<CalenderMonthScreen> {
  List<String> tasks = [];
  String selectedCategory = "Personal";
  List<String> categories = ["Personal", "Work", "Health", "Shopping"];
  TextEditingController projectController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  DateTime? selectedDate;
  void addTask() {
    if (projectController.text.isEmpty) return;
    setState(() {
      tasks.add(projectController.text);
      projectController.clear();
      dateController.clear();
      timeController.clear();
      reminderController.clear();
      notesController.clear();
      selectedCategory = "Personal";
    });
  }
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
        "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }
  Future<void> _pickTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? "AM" : "PM";

      setState(() {
        controller.text = "$hour:$minute $period";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllTasksScreen()),
          );
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.check, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 10),
                Text("Add Task",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 15),
                TextField(
                  controller: projectController,
                  decoration: InputDecoration(
                    hintText: "New Project",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("Category",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: selectedCategory,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      itemBuilder: (context) {
                        return categories
                            .map((cat) => PopupMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                            .toList();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("Select Date",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "2025/06/10",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: _pickDate,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("Set Time",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "1:43 PM",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => _pickTime(timeController),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("Set Reminder",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  controller: reminderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "2:00 PM",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () => _pickTime(reminderController),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("Notes",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    hintText: "Meeting about the project",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index]),
                    );
                  },
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}