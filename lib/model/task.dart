class Task {

	int? id;
	String title;
	String description;
	String date;

	Task(this.id, this.title, this.date, this.description);

	Task.withId(this.id, this.title, this.date, this.description);


	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = <String, dynamic>{};
		map['title'] = title;
		map['description'] = description;
		map['date'] = date;

		return map;
	}

}