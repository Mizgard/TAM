class Task {
  final int id;
  final String title;
  final String deadline;
  final bool done;
  final String priority;

  const Task({
    required this.id,
    required this.title,
    required this.deadline,
    required this.done,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "deadline": deadline,
      "priority": priority,
      "done": done,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      title: map["title"],
      deadline: map["deadline"],
      priority: map["priority"],
      done: map["done"],
    );
  }
}

class TaskRepository {
  static final List<Task> tasks = [];

  static List<Task> getAll() => tasks;

  static void addTask(Task task) {
    tasks.add(task);
  }

  static void updateTask(Task task) {
    final index = tasks.indexWhere((item) => item.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
  }

  static void removeTask(int id) {
    tasks.removeWhere((item) => item.id == id);
  }

  static void clear() {
    tasks.clear();
  }
}
