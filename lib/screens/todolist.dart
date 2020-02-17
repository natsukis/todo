import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';

class TodoList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State{
  DbHelper helper = DbHelper();
  List<Todo> todos;
  int count = 0;

  @override
  Widget build(BuildContext context) {
      if (todos == null){
        todos = List<Todo>();
        getData();
      }
    return Scaffold(
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: "Add new Todo",
        child: new Icon(Icons.add)
        ),
    );
  }

  ListView todoListItems(){
    return ListView.builder();
  }

void getData(){
  final dbFuture = helper.initializeDb();
  dbFuture.then((result){
    final todosFuture = helper.getTodos();
    todosFuture.then((result){
      List<Todo> todoList = List<Todo>();
      count = result.length;
      for(int i=0; i<count ; i++){
          todoList.add(Todo.fromObject(result[i]));
          debugPrint(todoList[i].title);
      }
      setState(() {
        todos = todoList;
        count = count;
      });
      debugPrint("Item: " + count.toString());
    });
  });
}

}