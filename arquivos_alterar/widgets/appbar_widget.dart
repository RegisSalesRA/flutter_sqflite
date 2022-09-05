import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  Widget? actionsAppBar;

  MyAppBar({Key? key, this.title, this.actionsAppBar}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(
        title!,
        style: const TextStyle(),
      ),
      actions: [actionsAppBar!],
    );
  }
}
