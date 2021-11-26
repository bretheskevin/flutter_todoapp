class Todo {
  int id;
  String content;

  Todo(this.id, this.content);

  Map toJson() {
    return {"id": id, "content": content};
  }
}