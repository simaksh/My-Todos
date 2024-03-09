class EditTodoDto {
  final int userId;
  final String title;
  final String id;
  final bool isCompleted;

  EditTodoDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'completed': isCompleted,
  };
}
