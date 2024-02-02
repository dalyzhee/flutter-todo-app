import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/completed.dart';
import 'package:todo/providers/todo_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos = todos
        .where(
          (todo) => todo.completed == false,
        )
        .toList();
    List<Todo> completedTodos = todos
        .where(
          (todo) => todo.completed == true,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
        ),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (context, index) {
          if (index == activeTodos.length) {
            if (activeTodos.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Center(
                  child: Text("Add a todo using the button below."),
                ),
              );
            }
            if (completedTodos.isEmpty) {
              return Container();
            } else {
              return Center(
                child: TextButton(
                  child: const Text("Completed Todos"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CompletedPage()));
                  },
                ),
              );
            }
          } else {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: ListTile(
                title: Text(activeTodos[index].content),
                leading: TextButton(
                    onPressed: () {
                      ref
                          .watch(todoProvider.notifier)
                          .completedTodo(activeTodos[index].todoId);
                    },
                    child: const Icon(Icons.check)),
                trailing: TextButton(
                    onPressed: () {
                      ref
                          .watch(todoProvider.notifier)
                          .deleteTodo(activeTodos[index].todoId);
                    },
                    child: const Icon(Icons.delete)),
              ),
            );
          }
          // Slidable(
          // startActionPane: ActionPane(
          //   motion: const ScrollMotion(),
          //   children: [
          //     SlidableAction(
          //       onPressed: (context) {
          //         ref.watch(todoProvider.notifier).deleteTodo(index);
          //       },
          //       backgroundColor: Colors.red,
          //       borderRadius: const BorderRadius.all(Radius.circular(20)),
          //       icon: Icons.delete,
          //     )
          //   ],
          // ),
          //   child: ListTile(
          //     title: Text(todos[index].content),
          //     leading: TextButton(
          //         onPressed: () {}, child: const Icon(Icons.thumb_up)),
          //     trailing: TextButton(
          //         onPressed: () {
          //           ref.watch(todoProvider.notifier).deleteTodo(index);
          //         },
          //         child: const Icon(Icons.delete)),
          //   ),
          // );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        tooltip: 'Increment',
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
