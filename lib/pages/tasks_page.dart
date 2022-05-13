import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:todos_remake/models/task_list.dart';
import 'package:todos_remake/models/task_model.dart';
import 'package:todos_remake/services/task_storage.dart';

import '../widgets/description_task_popup.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TaskList _taskList = TaskList();
  final Storage _storage = Storage();

  void deleteTask(int index) {
    _storage.deleteTask(key: _taskList.taskList[index].id.toString());
    setState(() {
      _taskList.taskList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
        border: Border(bottom: BorderSide.none),
        middle: Text('Блокнот', style: TextStyle(fontSize: 30)),
        trailing: CupertinoButton(
            padding: EdgeInsets.all(0),
            onPressed: null,
            child: Text('Фильтр',
                style: TextStyle(fontSize: 16, color: Color(0xFF3BB75F)))),
      ),
      child: Center(
        child: FutureBuilder(
          future: _storage.getTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  color: Color(0xFF3BB75F),
                  radius: 20,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return const Center(child: Text('Data not found'));
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              _taskList.taskList = snapshot.data as List<Task>;
              return buildListOfCards();
            } else {
              return const Center(child: Text('default'));
            }
          },
        ),
      ),
    );
  }

  ListView buildListOfCards() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: _taskList.taskList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.horizontal,
          onDismissed: (_) {
            deleteTask(index);
          },
          key: Key(index.toString()),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => showPopupDescriptionTask(
              index.toString(),
              _taskList.taskList[index].text,
              _taskList.taskList[index].startTime,
              _taskList.taskList[index].endTime,
            ),
            child: Container(
              child: CupertinoListTile(
                border: const Border(bottom: BorderSide.none),
                title: Text(
                  _taskList.taskList[index].text,
                  style: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.delete,
                    color: Color(0xFFA4A4A4),
                  ),
                  onPressed: () {
                    deleteTask(index);
                  },
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
            ),
          ),
        );
      },
    );
  }

  void showPopupDescriptionTask(
    String id,
    String taskText,
    DateTime beginTime,
    DateTime endTime,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return DescriptionTaskPopup(
            id: id, textTask: taskText, beginTime: beginTime, endTime: endTime);
      },
    );
  }
}
