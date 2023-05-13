import 'dart:async';
import 'package:flutter/material.dart';
import '../model/task.dart';
import '../database/helper.dart';
import 'package:intl/intl.dart';

class TaskInfo extends StatefulWidget {

	final String appBarTitle;
	final Task task;

	TaskInfo(this.task, this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return TaskInfoState(this.task, this.appBarTitle);
  }
}

class TaskInfoState extends State<TaskInfo> {

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	Task task;

	TextEditingController titleController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();

	TaskInfoState(this.task, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

		titleController.text = task.title;
		descriptionController.text = task.description;

    return WillPopScope(

	    onWillPop: () {
		    moveToLastScreen();
        return Future.value(true);
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    moveToLastScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: titleController,
						    style: textStyle,
						    onChanged: (value) {
						    	updateTitle();
						    },
						    decoration: InputDecoration(
							    labelText: 'Title',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: descriptionController,
						    style: textStyle,
						    onChanged: (value) {
							    updateDescription();
						    },
						    decoration: InputDecoration(
								    labelText: 'Description',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: ElevatedButton(
									    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        textStyle: TextStyle(color: Theme.of(context).primaryColorLight)
                      ),
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  _save();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),
                  
							    Expanded(
								    child: ElevatedButton(
									    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        textStyle: TextStyle(color: Theme.of(context).primaryColorLight)
                      ),
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),


			    ],
		    ),
	    ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

	// Update the title of task object
  void updateTitle(){
    task.title = titleController.text;
  }

	// Update the description of task object
	void updateDescription() {
		task.description = descriptionController.text;
	}

	// Save data to database
	void _save() async {

		moveToLastScreen();

		task.date = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (task.id != null) {
			result = await helper.updateTask(task);
		} else {
			result = await helper.insertTask(task);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'Task Saved Successfully');
		} else {  // Failure
			_showAlertDialog('Status', 'Problem Saving Task');
		}

	}


	void _delete() async {

		moveToLastScreen();

		if (task.id == null) {
			_showAlertDialog('Status', 'No Task was deleted');
			return;
		}
    var id = task.id?.toInt() ?? 0; 
		int result = await helper.deleteTask(id);
		if (result != 0) {
			_showAlertDialog('Status', 'Task Deleted Successfully');
		} else {
			_showAlertDialog('Status', 'Error Occured while Deleting Task');
		}
	}

	void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}

}