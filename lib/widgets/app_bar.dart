import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MainAppBar({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
      ),
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_rounded,
              color: Colors.black,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
