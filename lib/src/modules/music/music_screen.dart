import 'package:flutter/material.dart';
import 'package:flutter_sqlite/config/colors.dart';
import 'package:flutter_sqlite/data/database_service.dart';
import 'package:flutter_sqlite/model/music.dart';

import 'package:flutter_sqlite/src/modules/music/music_form.dart';
import '../../widgets/widgets.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Music>> _getMusics() async {
    return await _databaseService.musics();
  }

  Future<void> onMusicDelete(Music music) async {
    await _databaseService.deleteMusic(music.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (_) => const MusicScreenForm(),
                  ),
                )
                .then((_) => setState(() {}));
          },
          backgroundColor: Palette.primaryColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBarWidget(
          actions: const SizedBox(),
          title: 'Music Screen',
          onTap: () => Navigator.pushNamed(context, '/'),
        ),
        body: FutureBuilder<List<Music>>(
            future: _getMusics(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && !snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final music = snapshot.data![index];
                      return CustomCardWidget(
                        onTap: null,
                        details: false,
                        music: music,
                        onDetails: null,
                        onDelete: onMusicDelete,
                        children: [
                          Text(
                            'Musica - ${music.name}',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Album - ${music.description}",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                        onEdit: (value) {
                          {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        MusicScreenForm(music: value),
                                  ),
                                )
                                .then((_) => setState(() {}));
                          }
                        },
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text("Nenhum dado cadastrado"));
              }
            }),
      ),
    );
  }
}
