import 'package:flutter/material.dart';
import 'package:flutter_sqlite/config/config.dart';

import '../../data/database_service.dart';
import '../../model/model.dart';

class CustomCardWidget extends StatefulWidget {
  final Music music;
  final Function(Music)? onDetails;
  final Function(Music)? onEdit;
  final Function(Music)? onDelete;
  final bool details;
  final Function()? onTap;
  const CustomCardWidget({
    Key? key,
    required this.music,
    required this.onDetails,
    required this.onEdit,
    required this.onDelete,
    required this.details,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  final DatabaseService _databaseService = DatabaseService();

  Album albumMusica = Album();

  Future albumById() async {
    var data = await _databaseService.album(widget.music.albumId);
    if (widget.music.albumId! > 0 && data != null) {
      setState(() {
        albumMusica = data;
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    albumById();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                child: Icon(
                  Icons.music_note,
                  color: Colors.grey.shade400,
                  size: 26,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.width * 0.65,
                    child: Text(
                      widget.music.name!,
                      style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          color: Palette.primaryColorLight),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: size.width * 0.65,
                    child: Text(
                      albumMusica.name == null
                          ? "No album"
                          : albumMusica.name.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey.shade400),
                    ),
                  )
                ],
              )
            ]),
            if (widget.details == true)
              Row(mainAxisSize: MainAxisSize.min, children: [
                InkWell(
                  onTap: () => widget.onDetails!(widget.music),
                  child: Icon(
                    Icons.assignment,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: widget.onTap,
                  child: SizedBox(
                    child: widget.music.isFavorite == 1
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.grey.shade400,
                          ),
                  ),
                )
              ])
            else
              Row(mainAxisSize: MainAxisSize.min, children: [
                InkWell(
                  onTap: () => widget.onEdit!(widget.music),
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => widget.onDelete!(widget.music),
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
