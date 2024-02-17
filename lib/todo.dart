import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Task> taskList = [
    Task(description: "eating", time: "12:00 PM", starred: false),
    Task(description: "learning", time: "3:30 PM", starred: false),
    Task(description: "reading", time: "6:45 PM", starred: false),
  ];

  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  void addTask() {
    setState(() {
      if (descriptionController.text.isNotEmpty) {
        taskList.add(
          Task(
            description: descriptionController.text,
            time: timeController.text,
            starred: false,
          ),
        );
      }
    });
    descriptionController.clear();
    timeController.clear();
  }

  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void updateTask(int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Update Task",
            style: TextStyle(color: Colors.pink),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Task',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink, // Set the border color when focused
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink, // Set the border color when focused
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  taskList[index] = Task(
                    description: descriptionController.text,
                    time: timeController.text,
                    starred: taskList[index].starred,
                  );
                });
                descriptionController.clear();
                timeController.clear();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.pink;
                    }
                    return const Color(0xFFFFBAD1);
                  },
                ),
              ),
              child: const Text("Update Task"),
            ),
          ],
        );
      },
    );
  }

  void toggleStar(int index) {
    setState(() {
      taskList[index] = Task(
        description: taskList[index].description,
        time: taskList[index].time,
        starred: !taskList[index].starred,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFBAD1),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TODO APP",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.assignment, color: Colors.white),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.pink,
            labelColor: Colors.pink,
            tabs: [
              Tab(text: "All Tasks"),
              Tab(text: "Starred Tasks"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // All Tasks Tab
            ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                Task task = taskList[index];
                return ListTile(
                  title: Text("Task: ${task.description}"),
                  subtitle: Text("Time: ${task.time}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => updateTask(index),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => deleteTask(index),
                        icon: const Icon(Icons.delete_outline),
                      ),
                      IconButton(
                        onPressed: () => toggleStar(index),
                        icon: task.starred
                            ? const Icon(Icons.star, color: Colors.pink)
                            : const Icon(Icons.star_border),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Starred Tasks Tab
            ListView.builder(
              itemCount: taskList.where((task) => task.starred).length,
              itemBuilder: (context, index) {
                Task task =
                    taskList.where((task) => task.starred).toList()[index];
                return ListTile(
                  title: Text(
                    "Task: ${task.description}",
                    style: TextStyle(
                      color: Colors.pink,
                    ),
                  ),
                  subtitle: Text("Time: ${task.time}"),
                  trailing: const Icon(Icons.star, color: Colors.pink),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    "Add Task",
                    style: TextStyle(color: Colors.pink),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Task',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .pink, // Set the border color when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: timeController,
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .pink, // Set the border color when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        addTask();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.pink;
                            }
                            return const Color(0xFFFFBAD1);
                          },
                        ),
                      ),
                      child: const Text("Add Task"),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: const Color(0xFFFFBAD1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.add, color: Colors.pink),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class Task {
  final String description;
  final String time;
  final bool starred;

  Task({
    required this.description,
    required this.time,
    required this.starred,
  });
}
