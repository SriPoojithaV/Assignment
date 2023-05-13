import 'dart:async';
import 'package:flutter/material.dart';
import '../model/task.dart';
import '../database/helper.dart';
import '../screen/task_info.dart';
import 'package:sqflite/sqflite.dart';

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskListState();
  }
}

class TaskListState extends State<TaskList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> tasks = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: getTaskListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Task(null, '', '', ''), 'Add Task');
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTaskListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstLetter(tasks[position].title),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(tasks[position].title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(tasks[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,),
                  onTap: () {
                    _showAlert(context, tasks[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              navigateToDetail(tasks[position], 'Edit Task');
            },
          ),
        );
      },
    );
  }

  Future<void> _showAlert(context, Task task) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm to delete the task'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('do you really want to delete the task - ${task.title}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _delete(context, task);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, Task task) async {
    var id = task.id?.toInt() ?? 0;
    int result = await databaseHelper.deleteTask(id);
    if (result != 0) {
      _showSnackBar(context, 'Successfully Deleted Task');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Task task, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskInfo(task, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDb();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTasks();
      taskListFuture.then((savedTasks) {
        setState(() {
          tasks = savedTasks;
          count = savedTasks.length;
        });
      });
    });
  }

  
}