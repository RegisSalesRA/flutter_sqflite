import 'package:flutter/material.dart';

import '../data/database_service.dart';
import '../model/model.dart';

class AlbumHelper extends StatefulWidget {
  final Music music;
  const AlbumHelper({Key? key, required this.music}) : super(key: key);

  @override
  State<AlbumHelper> createState() => _AlbumHelperState();
}

class _AlbumHelperState extends State<AlbumHelper> {
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
    return SizedBox(
      width: size.width * 0.55,
      child: Text(
        albumMusica.name == null ? "No album" : albumMusica.name.toString(),
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            color: Colors.grey.shade400),
      ),
    );
  }
}
