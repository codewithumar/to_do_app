class Todo {
  int? id;
  final String title;
  final String description;
  DateTime creationDate;
  bool isChecked;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.isChecked,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isChecked': isChecked ? 1 : 0,
      'creationDate': creationDate.toString(),
    };
  }
}
