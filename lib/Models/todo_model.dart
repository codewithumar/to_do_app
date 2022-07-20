class Todo {
  int? id;
  final String title;
  DateTime creationDate;
  bool isChecked;

  Todo({
    this.id,
    required this.title,
    required this.isChecked,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isChecked': isChecked ? 1 : 0,
      'creationDate': creationDate.toString(),
    };
  }
}
