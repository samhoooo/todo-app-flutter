class Task {
  final String id;
  final String title;
  final String description;
  bool isChecked;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isChecked': isChecked,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      isChecked: map['isChecked'] ?? false,
    );
  }
}
