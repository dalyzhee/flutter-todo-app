import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo_provider.dart';

class CompletedPage extends ConsumerWidget {
  const CompletedPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> completedTodos = todos
        .where(
          (todo) => todo.completed == true,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Completed Todos",
        ),
      ),
      body: ListView.builder(
          itemCount: completedTodos.length,
          itemBuilder: (context, index) {
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
                title: Text(completedTodos[index].content),
                trailing: TextButton(
                    onPressed: () {
                      ref
                          .watch(todoProvider.notifier)
                          .deleteTodo(completedTodos[index].todoId);
                    },
                    child: const Icon(Icons.delete)),
              ),
            );
          }),
    );
  }
}
