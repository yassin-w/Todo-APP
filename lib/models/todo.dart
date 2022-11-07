// ignore_for_file: non_constant_identifier_names, unnecessary_this, unnecessary_new

class ToDo {
  String id;
  String name;
  String description;
  String date;
  bool isComplete;
  String userId;

  ToDo(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.isComplete,
      required this.userId});
}
