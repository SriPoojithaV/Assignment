import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/task.dart';
import 'package:flutter/material.dart';


class DatabaseHelper {

	static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
	static Database? _database;

	String tableName = 'task_table';
	String colId = 'id';
	String colTitle = 'title';
	String colDescription = 'description';
	String colDate = 'date';

	DatabaseHelper._createInstance();

	factory DatabaseHelper() {
		return _databaseHelper;
	}

	Future<Database> get database async =>
      _database ??= await initDb();


	Future<Database> initDb() async {
		String path = await getDatabasesPath() + ('/flutter_example.db');
		var taskDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return taskDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
				'$colDescription TEXT, $colDate TEXT)');
	}

	// Fetch Operation: Get all task objects from database
	Future<List<Map<String, dynamic>>> getTaskMapList() async {
		Database db = await database;

		var result = await db.query(tableName, orderBy: '$colTitle ASC');
		return result;
	}

	// Insert Operation: Insert a task object to database
	Future<int> insertTask(Task task) async {
		Database db = await database;
		var result = await db.insert(tableName, task.toMap());
		return result;
	}

	// Update Operation: Update a task object and save it to database
	Future<int> updateTask(Task task) async {
		var db = await database;
		var result = await db.update(tableName, task.toMap(), where: '$colId = ?', whereArgs: [task.id]);
		return result;
	}


	// Delete Operation: Delete a task object from database
	Future<int> deleteTask(int id) async {
		var db = await database;
		int result = await db.rawDelete('DELETE FROM $tableName WHERE $colId = $id');
		return result;
	}

	// Get number of task objects in database
	Future<int> getCount() async {
		Database db = await database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tableName');
		int result = Sqflite.firstIntValue(x) ??  0;
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'task List' [ List<task> ]
	Future<List<Task>> getTasks() async {

		var taskMapList = await getTaskMapList(); // Get 'Map List' from database
		int count = taskMapList.length;         // Count the number of map entries in db table

		List<Task> tasks = [];
		// For loop to create a 'todo List' from a 'Map List'
		for (int i = 0; i < count; i++) {
      Map<String, dynamic> map = taskMapList[i];
      Task task = Task.withId(map['id'], map['title'], map['date'], map['description']);
      tasks.add(task);
		}

		return tasks;
	}

}