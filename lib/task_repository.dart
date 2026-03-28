class TaskRepository{
    // Lista musi być final, aby klasa mogła mieć konstruktor const
  static List<Task> tasks = [
    Task(
      title: "Pranie",
      deadline: "Deadline: jutro",
      done: true,
      priority: "Wysoki",
    ),
    Task(
      title: "Ćwiczenia z linuxa",
      deadline: "Deadline: dzisiaj",
      done: false,
      priority: "Średni",
    ),
    Task(
      title: "Przeczytać o flutterze",
      deadline: "Deadline: w tym tygodniu",
      done: false,
      priority: "Niski",
    ),
    Task(
      title: "Przeczytać o html",
      deadline: "Deadline: w tym tygodniu",
      done: true,
      priority: "Niski",
    ),
  ];
}

class Task {
  final String title;
  final String deadline;
  final bool done;
  final String priority;
  const Task({
    required this.title,
    required this.deadline,
    required this.done,
    required this.priority,
  });
}