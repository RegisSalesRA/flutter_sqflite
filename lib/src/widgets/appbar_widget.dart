import 'package:flutter/material.dart';
import 'package:flutter_sqlite/config/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onTap;
  final Widget? actions;
  const AppBarWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.actions})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(color: Palette.primaryColor),
      ),
      leading: onTap == null ? const SizedBox() : InkWell(
          onTap: onTap,
          child: const Icon(
            Icons.arrow_back,
            color: Palette.primaryColor,
          )),
      actions: [actions!],
    );
  }
}
