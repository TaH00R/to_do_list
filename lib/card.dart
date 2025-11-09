import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String info;
  final bool completed;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onDelete;
  final VoidCallback? onRestore;
  final bool isDeletedPage;

  const TaskCard({
    super.key,
    required this.title,
    required this.info,
    required this.completed,
    this.onChanged,
    this.onDelete,
    this.onRestore,
    this.isDeletedPage = false,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          if (!widget.isDeletedPage)
            Checkbox(
              value: widget.completed,
              onChanged: widget.onChanged,
              activeColor: Colors.blue,
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: widget.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.redAccent,
                    decorationThickness: 2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.info,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          widget.isDeletedPage
              ? IconButton(
                  icon: const Icon(Icons.restore, color: Colors.greenAccent),
                  onPressed: widget.onRestore,
                )
              : IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Delete"),
                        content:
                            const Text("Do you really want to delete this task?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              widget.onDelete?.call();
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
