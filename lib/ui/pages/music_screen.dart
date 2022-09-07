import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';
import 'package:flutter_sqlite/model/music.dart';

import 'package:flutter_sqlite/ui/forms/music_form.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';

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
                    builder: (_) => MusicScreenForm(),
                  ),
                )
                .then((_) => setState(() {}));
          },
          child: Text(
            "+",
            style: TextStyle(fontSize: 20),
          ),
        ),
        appBar: MyAppBar(
          title: "Musica Widget",
          actionsAppBar: Container(),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Music>>(
                future: _getMusics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData && !snapshot.hasError) {
                    return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final music = snapshot.data![index];
                              return CardWdiget(
                                music: music,
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
                        ));
                  } else {
                    return Container(
                      child: Center(child: Text("Nenhum dado cadastrado")),
                    );
                  }
                })));
  }
}

class CardWdiget extends StatelessWidget {
  Music music;
  final Function(Music) onEdit;
  final Function(Music) onDelete;

  CardWdiget({
    Key? key,
    required this.music,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      music.title.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text('Age: ${music.description.toString()}'),
                        Container(
                          height: 15.0,
                          width: 15.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              width: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.0),
              GestureDetector(
                onTap: () => onEdit(music),
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.edit,
                  ),
                ),
              ),
              SizedBox(width: 20.0),
              GestureDetector(
                onTap: () => onDelete(music),
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.delete,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
