import 'package:flutter/material.dart';
import 'tasks.dart';
import 'card.dart';
import 'appbar.dart';

class DeletedPage extends StatefulWidget {
  const DeletedPage({super.key});

  @override
  State<DeletedPage> createState() => _DeletedPageState();
}

class _DeletedPageState extends State<DeletedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassAppBar(title: "Recently Deleted"),
      body: deletedTasks.isEmpty
          ? const Center(
              child: Text("No deleted tasks yet", style: TextStyle(color: Colors.white70)),
            )
          : ListView.builder(
              itemCount: deletedTasks.length,
              itemBuilder: (context, index) {
                final task = deletedTasks[index];
                return TaskCard(
                  title: task['title'] ?? '',
                  info: task['info'] ?? '',
                  completed: task['completed'] ?? false,
                  isDeletedPage: true,
                  onRestore: () {
                    setState(() {
                      tasks.add(task);
                      deletedTasks.removeAt(index);
                    });
                  },
                );
              },
            ),
    );
  }
}
