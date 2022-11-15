import 'package:flutter/material.dart';

import '../../data/database_service.dart';
import '../../model/model.dart';
import 'widgets.dart';

class MusicWidget extends StatefulWidget {
  final dynamic Function(Music)? onDetails;
  final String buscarMusicas;
  final Size size;
  final Future<List<Music>> futureListMusics;

  const MusicWidget(
      {Key? key,
      required this.size,
      required this.futureListMusics,
      required this.buscarMusicas,
      required this.onDetails})
      : super(key: key);

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.size.height * 0.35,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Music>>(
                future: widget.futureListMusics,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      break;
                    case ConnectionState.active:
                      break;
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();

                    case ConnectionState.done:
                      if (snapshot.hasData && !snapshot.hasError) {
                        if (snapshot.data!.isNotEmpty) {
                          return SizedBox(
                              height: widget.size.height * 0.45,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          final music = snapshot.data![index];
                                          return snapshot.data![index].name
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(
                                                      widget.buscarMusicas)
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    if (music.isFavorite == 1) {
                                                      await _databaseService
                                                          .updateMusicFavorite(
                                                        0,
                                                        music.id!,
                                                      );
                                                    } else {
                                                      await _databaseService
                                                          .updateMusicFavorite(
                                                              1, music.id!);
                                                    }
                                                  },
                                                  child: CustomCardWidget(
                                                      music: music,
                                                      onDetails:
                                                          widget.onDetails,
                                                      onDelete: null,
                                                      onEdit: null,
                                                      details: true,
                                                      children: [
                                                        Text(
                                                          music.name.toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2,
                                                        )
                                                      ]),
                                                )
                                              : Container();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        } else {
                          return SizedBox(
                              height: widget.size.height * 0.35,
                              width: widget.size.width,
                              child: const Center(
                                child: Text("Nenhuma musica cadastrada!"),
                              ));
                        }
                      }
                  }
                  return Container();
                },
              ),
            ),
          ],
        ));
  }
}
