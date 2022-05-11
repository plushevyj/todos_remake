import 'package:flutter/cupertino.dart';
import 'package:todos_remake/services/counter.dart';
import 'package:todos_remake/services/task_storage.dart';

class PopupAddNewTask extends StatefulWidget {
  const PopupAddNewTask({Key? key}) : super(key: key);

  @override
  State<PopupAddNewTask> createState() => _PopupAddNewTaskState();
}

class _PopupAddNewTaskState extends State<PopupAddNewTask> {
  final Counter _counter = Counter();
  DateTime dateTime = DateTime.now();
  String taskText = '';
  final Storage _storage = Storage();

  void addTask() {
    int maxIndex = _counter.getMaxValueOfCounter() as int;
    _storage.postTask(
      key: maxIndex + 1,
      text: taskText,
      startTime: DateTime.now(),
      endTime: dateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(this),
      direction: DismissDirection.down,
      onDismissed: (direction) =>
          direction == DismissDirection.down ? Navigator.pop(context) : null,
      child: CupertinoPopupSurface(
        child: Container(
            padding: const EdgeInsetsDirectional.all(20),
            color: CupertinoColors.white,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).copyWith().size.height * 0.87,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  margin: const EdgeInsets.only(
                    left: 165,
                    right: 165,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Добавить новую запись',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: CupertinoTextField(
                    onChanged: (value) {
                      taskText = value;
                    },
                    decoration: BoxDecoration(
                      border: const Border(bottom: BorderSide.none),
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    placeholder: 'Текст',
                    placeholderStyle: const TextStyle(color: Color(0xBB3BB75F)),
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14,
                    ),
                    maxLines: 15,
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Задачу выполнить до:',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AbsorbPointer(
                  absorbing: false,
                  child: SizedBox(
                    height: 150,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (value) {
                        setState(() {
                          dateTime = value;
                        });
                      },
                      minimumDate: DateTime.now(),
                      use24hFormat: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoButton(
                    color: const Color(0xFF3BB75F),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'Сохранить',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onPressed: () {}),
                CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Отменить',
                    style: TextStyle(color: Color(0xFF3BB75F)),
                  ),
                ),
              ],
            )),
        isSurfacePainted: true,
      ),
    );
  }
}
