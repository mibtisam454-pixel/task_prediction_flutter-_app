import 'package:flutter/material.dart';


class AllTaskProgressScreen extends StatefulWidget {
  @override
  AllTaskProgressScreenState createState() => AllTaskProgressScreenState();
}

class AllTaskProgressScreenState extends State<AllTaskProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(10),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children:  [
              IconButton(
                icon: Icon(Icons.arrow_back),onPressed: () {
                  Navigator.pop(context);
              },

              ),
              Text(
                "All Task progress",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              TaskCardWidget(
                title: "Work",
                icon: Icons.business_center_outlined,
                color: Colors.purple,
                totalTasks: 3,
                completedTasks: 1,
              ),
              TaskCardWidget(
                title: "Personal",
                icon: Icons.person_outline,
                color: Colors.orange,
                totalTasks: 2,
                completedTasks: 1,
              ),
              TaskCardWidget(
                title: "Health",
                icon: Icons.shield_outlined,
                color: Colors.amber,
                totalTasks: 0,
                completedTasks: 0,
              ),
              TaskCardWidget(
                title: "Shopping",
                icon: Icons.shopping_cart_outlined,
                color: Colors.redAccent,
                totalTasks: 0,
                completedTasks: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int totalTasks;
  final int completedTasks;

  const TaskCardWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.totalTasks,
    required this.completedTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double progress = totalTasks == 0 ? 0 : completedTasks / totalTasks;
    int pendingPercent = totalTasks == 0
        ? 100
        : (((totalTasks - completedTasks) / totalTasks) * 100).toInt();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [

          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: color),
                ),
              ),

              Text(
                "$totalTasks Task ($completedTasks-completed)",
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  color: color,
                  backgroundColor: Colors.grey.shade300,
                  minHeight: 6,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "$pendingPercent% Pending",
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}