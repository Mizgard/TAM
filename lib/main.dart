
import 'package:flutter/material.dart';
import 'task_repository.dart';
import 'services/task_sync_service.dart';
// import 'services/task_api_services.dart';
import 'services/task_local_db.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'dart:math';
final random = Random();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // inicjalizacja
  await Hive.openBox("tasks"); // otwarcie kontenera
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'KrakFlow', home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
Future<List<Task>> loadTasks() async {
  await TaskSyncService.loadInitialDataIfNeeded();
  return TaskLocalDatabase.getTasks();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> tasksFuture;

  @override
  void initState() {
    super.initState();
    tasksFuture = loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "KrakFlow",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Task>>(
        future: tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
    } 
          else if (snapshot.hasError) {
              return Center(
              child: Text("Błąd: ${snapshot.error}"),);
              }
          else if (!snapshot.hasData) {
            return const Center(
              child: Text('Brak zadań'),
            );
          }

          final tasks = snapshot.data ?? [];
          final completedTasks = tasks.where((task) => task.done).length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Zadania',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text("Razem: ${tasks.length} zadań"),
                Text(
                  "Wykonane: $completedTasks zadań",
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TaskCard(
                          title: task.title,
                          subtitle: task.deadline,
                          priority: task.priority,
                          done: task.done,
                          onToggleDone: () async{
                            final updatedTask = Task(
                                id: task.id,
                                title: task.title,
                                deadline: task.deadline,
                                priority: task.priority,
                                done: !task.done,
                              );
                            await TaskLocalDatabase.updateTask(updatedTask);
                            setState(() {
                              tasksFuture = loadTasks();
                              });
                            }
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AddTaskScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    final offsetAnimation = Tween<Offset>(
                      begin: Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
            ),
          );
          if (newTask != null) {
            await TaskLocalDatabase.addTask(newTask);
            setState(() {
              tasksFuture = loadTasks();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nowe zadanie")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Tytuł zadania",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                labelText: "Deadline",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: priorityController,
              decoration: InputDecoration(
                labelText: "Priorytet",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  id: Random().nextInt(1000000),
                  title: titleController.text,
                  deadline: deadlineController.text,
                  priority: priorityController.text,
                  done: false,
                );
                // TaskRepository.tasks.add(newTask);
                Navigator.pop(context, newTask);
              },
              child: Text("Dodaj zadanie"),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool done;
  final String priority;
  final VoidCallback onToggleDone;

  const TaskCard({
    required this.title,
    required this.subtitle,
    required this.priority,
    required this.done,
    required this.onToggleDone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            done ? Icons.check_box : Icons.check_box_outline_blank,
            color: done ? Colors.green : null,
          ),
          onPressed: onToggleDone,
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration: done ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Text(priority),
        onTap: onToggleDone,
      ),
    );
  }
}
