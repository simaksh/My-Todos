class RepositoryUrls {
  static const String webBaseUrl = '127.0.0.1:3000';
  static const String emulatorBaseUrl = '10.0.2.2:3000';

  static const String getTodos = '/todos';
  static const String addTodo = '/todos';
  static String deleteTodo(String id) => '/todos/$id';
  static String editTodo(String id) => '/todos/$id';
}
