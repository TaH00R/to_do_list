import 'package:flutter/material.dart';
import 'tasks.dart';

class TaskSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search tasks...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.white70);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = tasks.where((task) {
      final title = task['title'].toString().toLowerCase();
      final info = task['info'].toString().toLowerCase();
      return title.contains(query.toLowerCase()) || info.contains(query.toLowerCase());
    }).toList();

    return results.isEmpty
        ? const Center(
            child: Text('No matching tasks found.', style: TextStyle(color: Colors.white70)),
          )
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final task = results[index];
              return ListTile(
                title: Text(task['title'], style: const TextStyle(color: Colors.white)),
                subtitle: Text(task['info'], style: const TextStyle(color: Colors.white70)),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = tasks.where((task) {
      final title = task['title'].toString().toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final task = suggestions[index];
        return ListTile(
          title: Text(task['title'], style: const TextStyle(color: Colors.white)),
          onTap: () {
            query = task['title'];
            showResults(context);
          },
        );
      },
    );
  }
}
