import 'package:flutter/material.dart';
import 'package:flutter_sqlite/config/config.dart';

import '../../model/model.dart';

class CustomCardWidget extends StatelessWidget {
  final Music music;
  final Function(Music)? onDetails;
  final Function(Music)? onEdit;
  final Function(Music)? onDelete;
  final bool details;
  final List<Widget>? children;
  const CustomCardWidget(
      {Key? key,
      required this.music,
      required this.onDetails,
      required this.onEdit,
      required this.onDelete,
      required this.details,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: Icon(
                      Icons.music_note,
                      color: Colors.grey.shade400,
                      size: 26,
                    )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    music.title!,
                    style: const TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Palette.primaryColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Album',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey.shade400),
                  )
                ],
              )
            ]),
            if (details == true)
              Row(mainAxisSize: MainAxisSize.min, children: [
                InkWell(
                  onTap: () => onDetails!(music),
                  child: Icon(
                    Icons.assignment,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.favorite_border,
                  color: Colors.grey.shade400,
                ),
              ])
            else
              Row(mainAxisSize: MainAxisSize.min, children: [
                InkWell(
                  onTap: () => onEdit!(music),
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => onDelete!(music),
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey.shade400,
                  ),
                ),
              ])
          ],
        ));
  }
}
