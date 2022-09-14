import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';
import 'package:flutter_sqlite/model/music.dart';

import 'package:flutter_sqlite/ui/forms/music_form.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';

import '../../widgets/card_widget.dart';

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
  void initState() {
    super.initState();
    _getMusics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: const Text(
            "+",
            style: TextStyle(fontSize: 20),
          ),
        ),
        appBar: AppBarWidget(
          title: "Musica Widget",
          actionsAppBar: Container(),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Music>>(
                future: _getMusics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData && !snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final music = snapshot.data![index];
                          return CustomCardWidget(
                            details: false,
                            music: music,
                            onDetails: null,
                            onDelete: onMusicDelete,
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
                })));
  }
}
