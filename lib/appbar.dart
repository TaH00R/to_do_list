import 'dart:ui';
import 'package:flutter/material.dart';
import 'search_delegates.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GlassAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.maybeOf(context)?.padding.top ?? 0.0;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: kToolbarHeight + topPadding,
          padding: EdgeInsets.only(top: topPadding),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: TaskSearchDelegate());
                },
                icon: const Icon(Icons.search, color: Colors.white),
              ),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 0.8)),
              PopupMenuButton<String>(
                color: Colors.black.withOpacity(0.85),
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == 'recent') Navigator.pushNamed(context, '/deleted');
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                      value: 'recent',
                      child: Text('Recently Deleted',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
