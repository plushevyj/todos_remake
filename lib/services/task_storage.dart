import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todos_remake/models/task_model.dart';

class Storage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<Task>> getTasks() async {
    Map<String, String> tasks = await _storage.readAll();
    List<Task> listTasks = [];
    tasks.forEach((key, value) {
      listTasks.add(Task.fromJson(jsonDecode(value)));
    });
    return listTasks;
  }

  Future<void> postTask({required int key, required String text, required DateTime startTime, required DateTime endTime}) async {
    await _storage.write(key: key.toString(), value: Task(key, text, startTime, endTime).toString());
  }

  Future<void> deleteTask({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> cleanStorage() async {
    await _storage.deleteAll();
  }
}
