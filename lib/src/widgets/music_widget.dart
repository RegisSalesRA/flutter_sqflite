import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../config/config.dart';
import '../../data/database_service.dart';
import '../../model/model.dart';
import '../modules/music/music_detail_screen.dart';

class MusicWidget extends StatefulWidget {
  final ValueNotifier musicFavorite;
  final String buscarMusicas;
  final double size;
  final DatabaseService databaseService;

  const MusicWidget(
      {Key? key,
      required this.size,
      required this.buscarMusicas,
      required this.databaseService,
      required this.musicFavorite})
      : super(key: key);

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  final DatabaseService _databaseService = DatabaseService();
  Future<void> getMusicsFavorite() async {
    var request = await _databaseService.musics();
    widget.musicFavorite.value = [...request];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.size,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ValueListenableBuilder(
                  valueListenable: widget.musicFavorite,
                  builder: (context, value, child) {
                    return widget.musicFavorite.value.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.musicFavorite.value.length,
                            itemBuilder: (context, index) {
                              final music = widget.musicFavorite.value[index];
                              return music.name!
                                      .toString()
                                      .toLowerCase()
                                      .contains(widget.buscarMusicas)
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Icon(
                                                Icons.music_note,
                                                color: Colors.grey.shade400,
                                                size: 26,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      music.name!,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Palette
                                                              .primaryColorLight),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    AlbumHelper(
                                                      music: music,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ]),
                                          Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                DetailScreen(
                                                                    music:
                                                                        music),
                                                          ),
                                                        )
                                                        .then((_) =>
                                                            setState(() {}));
                                                  },
                                                  child: Icon(
                                                    Icons.assignment,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                LikeButton(
                                                  onTap: (bool isLiked) async {
                                                    if (music.isFavorite == 1) {
                                                      await widget
                                                          .databaseService
                                                          .updateMusicFavorite(
                                                        0,
                                                        music.id!,
                                                      );
                                                      await getMusicsFavorite();
                                                    } else {
                                                      await widget
                                                          .databaseService
                                                          .updateMusicFavorite(
                                                              1, music.id!);
                                                      await getMusicsFavorite();
                                                    }
                                                    return !isLiked;
                                                  },
                                                  likeBuilder: (bool isLiked) {
                                                    print(isLiked);
                                                    return SizedBox(
                                                      child: music.isFavorite ==
                                                              1
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red)
                                                          : Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              color: Colors.grey
                                                                  .shade400,
                                                            ),
                                                    );
                                                  },
                                                  size: 25,
                                                ),
                                              ])
                                        ],
                                      ))
                                  : Container();
                            },
                          )
                        : const Center(child: Text("No registered music"));
                  },
                ),
              ),
            )
          ],
        ));
  }
}

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
    return Text(
      albumMusica.name == null ? "No album" : albumMusica.name.toString(),
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          color: Colors.grey.shade400),
    );
  }
}
