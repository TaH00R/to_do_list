import 'package:flutter/material.dart';
import 'appbar.dart';
import 'card.dart';
import 'tasks.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassAppBar(title: "To-Do List"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 1.2,
            colors: [Color(0xFF0A2342), Color(0xFF001833), Color(0xFF001020)],
            stops: [0.1, 0.6, 1.0],
          ),
        ),
        child: tasks.isEmpty
            ? const Center(
                child: Text("No tasks yet!",
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    title: task['title'] ?? '',
                    info: task['info'] ?? '',
                    completed: task['completed'] ?? false,
                    onChanged: (value) {
                      setState(() {
                        tasks[index]['completed'] = value ?? false;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        deletedTasks.add(tasks[index]);
                        tasks.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task Deleted!")));
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String title = '';
          String info = '';
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.white70),
                    ),
                    title: const Text("Add New Task", style: TextStyle(color: Colors.white)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: 'Title', labelStyle: TextStyle(color: Colors.white70)),
                          onChanged: (value) => title = value,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: 'Info', labelStyle: TextStyle(color: Colors.white70)),
                          onChanged: (value) => info = value,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel", style: TextStyle(color: Colors.redAccent))),
                      TextButton(
                          onPressed: () {
                            if (title.trim().isNotEmpty) {
                              setState(() {
                                tasks.add({'title': title, 'info': info, 'completed': false});
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Add", style: TextStyle(color: Colors.greenAccent))),
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
