class TodoViewModel {
  final int userId;
  final String id;
  final String title;
  final bool completed;

  TodoViewModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory TodoViewModel.fromJson(final Map<String, dynamic> json) =>
      TodoViewModel(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        completed: json['completed'],
      );
}
