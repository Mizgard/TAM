import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:krakflow/task_repository.dart';
import 'dart:math';
final random = Random();
final priorities = ["niski", "średni", "wysoki"];

class TaskApiService {
  static const String baseUrl = "https://dummyjson.com";

  static Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/todos"),
        headers: {"Content-Type": "application/json"},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Timeout podczas pobierania zadań');
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List todos = data["todos"];
        return todos.map((todo) {
          return Task(
            id: todo["id"],
            title: todo["todo"],
            deadline: "Brak terminu",
            done: todo["completed"] ?? false,
            priority: priorities[random.nextInt(priorities.length)],
          );
        }).toList();
      } else {
        throw Exception("Błąd pobierania danych: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Nie udało się pobrać zadań: $e");
    }
  }
}