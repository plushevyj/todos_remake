import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:todos_remake/models/task_model.dart';
import 'package:todos_remake/services/counter.dart';
import 'package:todos_remake/services/task_storage.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = [];
  final Counter _counter = Counter();
  final Storage _storage = Storage();
  late int maxIndex;

  void deleteTask(int index) {
    _storage.deleteTask(key: tasks[index].id.toString());
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    maxIndex = _counter.getMaxValueOfCounter() as int;
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
              ));
            } else if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return const Center(child: Text('Data not found'));
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              tasks = snapshot.data as List<Task>;
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
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        if (maxIndex < tasks[index].id) {
          maxIndex = tasks[index].id;
          _counter.setMaxValueOfCounter(maxIndex);
        }
        return Dismissible(
          direction: DismissDirection.horizontal,
          onDismissed: (_) {
            deleteTask(index);
          },
          key: Key(index.toString()),
          child: Container(
            child: CupertinoListTile(
              border: const Border(bottom: BorderSide.none),
              title: Text(
                tasks[index].text,
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
        );
      },
    );
  }
}
