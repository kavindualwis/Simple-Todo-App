import 'package:flutter/material.dart';
import 'package:simple_todo_app/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final taskController = TextEditingController();

  //Task list
  List todos = [];

  //Add new task to task list method
  void addList() {
    setState(() {
      todos.add(taskController.text);
      taskController.clear();
    });
  }

  //remove task from list
  void remove(int index) {
    String removedTask = todos[index];
    setState(() {
      todos.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 0, 193, 151),
        duration: const Duration(seconds: 3),
        content: const Text(
          'Task Removed',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              todos.insert(index, removedTask);
            });
          },
        ),
      ),
    );
  }

  //Pop up ModalBottomSheet Methods
  void addTask() {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 0, 193, 151),
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 700),
      ),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.yellow,
                  ),
                ),
                hintText: 'Add Task To List',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  addList();
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Add task',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 230, 0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 193, 151),
        title: const Text(
          'Simple Todo App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      //Floating Action button to pop up BotomSheet
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(
          Icons.task,
          color: Color.fromARGB(255, 0, 193, 151),
        ),
      ),

      //New task Listview
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TaskTile(
            text: todos[index],
            deleteFunction: (p0) => remove(index),
          );
        },
      ),
    );
  }
}
