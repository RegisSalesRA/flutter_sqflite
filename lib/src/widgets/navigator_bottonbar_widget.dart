import 'package:flutter/material.dart';

import '../../config/config.dart';

class NavigatorBottomBarWidget extends StatelessWidget {
  final BuildContext context;
  final double size;
  final void Function()? onTapFavorite;
  final void Function()? onTapAlbum;
  final void Function()? onTapCategory;
  final void Function()? onTapMusic;

  const NavigatorBottomBarWidget(
      {Key? key,
      required this.context,
      required this.size,
      required this.onTapFavorite,
      required this.onTapAlbum,
      required this.onTapCategory,
      required this.onTapMusic,
      
      
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Palette.primaryColorDark,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onTapFavorite,
            child: Icon(
              Icons.favorite_border,
              color: Colors.grey.shade400,
              size: 25,
            ),
          ),
          InkWell(
            onTap: onTapAlbum,
            child: Icon(
              Icons.album_rounded,
              color: Colors.grey.shade400,
              size: 25,
            ),
          ),
          InkWell(
            onTap: onTapCategory,
            child: Icon(
              Icons.category_outlined,
              color: Colors.grey.shade400,
              size: 25,
            ),
          ),
          InkWell(
            onTap: onTapMusic,
            child: Icon(
              Icons.music_note_outlined,
              color: Colors.grey.shade400,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
