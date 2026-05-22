import 'task_api_services.dart';
import 'task_local_db.dart';

class TaskSyncService {
  static Future<void> loadInitialDataIfNeeded() async {
    if (!TaskLocalDatabase.isEmpty()) {
      return;
    } final tasks = await TaskApiService.fetchTasks();
await TaskLocalDatabase.saveTasks(tasks);
    }
  }

