class TodoTaskModel {
  int? id;
  String? title;
  String? description;
  String? status;
  String? dueDate;
  String? createdAt;

  TodoTaskModel(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.dueDate,
      this.createdAt});

  TodoTaskModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["desc"] is String) {
      description = json["desc"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["dueDate"] is String) {
      dueDate = json["dueDate"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["desc"] = description;
    _data["status"] = status;
    _data["dueDate"] = dueDate;
    _data["createdAt"] = createdAt;
    return _data;
  }
}
