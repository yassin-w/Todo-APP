class TodoData {
  String name;
  String description;
  DateTime date;

  TodoData({required this.name, required this.description, required this.date});

  String get getName {
    return name;
  }

  void setName(String name) {
    name = name;
  }

  String get getDescription {
    return description;
  }

  void setDescription(String description) {
    description = description;
  }

  DateTime get getDate {
    return date;
  }

  void setDate(DateTime date) {
    date = date;
  }
}
