import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionsAppBar;

  const MyAppBar({Key? key, this.title, this.actionsAppBar}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.headline2,
      ),
      actions: [actionsAppBar!],
    );
  }
}
