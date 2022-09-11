import 'package:flutter/material.dart';
import 'package:flutter_sqlite/model/music.dart';

import '../css/colors.dart';

class CustomCardWidget extends StatelessWidget {
  Music music;
  final Function(Music) onEdit;
  final Function(Music) onDelete;
  CustomCardWidget({
    Key? key,
    required this.music,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        height: 100,
        margin: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColors.card,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32)),
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Musica - ${music.title}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "descrição - ${music.description}",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onEdit(music),
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onDelete(music)),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
