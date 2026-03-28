import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Lista musi być final, aby klasa mogła mieć konstruktor const
  final List<Task> tasks = const [
    Task(title: "Pranie", deadline: "Deadline: jutro",done: true, priority: "Wysoki"),
    Task(title: "Ćwiczenia z linuxa", deadline: "Deadline: dzisiaj", done: false, priority: "Średni"),
    Task(title: "Przeczytać o flutterze", deadline: "Deadline: w tym tygodniu", done: false, priority: "Niski"),
    Task(title: "Przeczytać o html", deadline: "Deadline: w tym tygodniu", done: true, priority: "Niski"),
  ];
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KrakFlow',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("KrakFlow", 
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Dzisiejsze zadania',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text("Masz ${tasks.length} zadania do wykonania"),
              Text("Masz ${tasks.where((task) => task.done).length} wykonanych zadań"),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding( 
                      padding: EdgeInsets.all(8.0),
                      child: TaskCard(
                        title: task.title,
                        subtitle: task.deadline,
                        priority: task.priority,
                        icon: task.done ? Icons.check_circle : Icons.radio_button_unchecked,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String priority;

  const TaskCard({
    required this.title,
    required this.subtitle,
    required this.priority,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(priority),
      ),
    );
  }
}

class Task {
  final String title;
  final String deadline;
  final bool done;
  final String priority;
  const Task({required this.title,
              required this.deadline,
              required this.done,
              required this.priority,});
}
