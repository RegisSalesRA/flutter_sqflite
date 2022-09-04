import 'package:flutter/material.dart';
import 'package:flutter_sqlite/css/colors.dart';
import 'package:flutter_sqlite/data/music_operation.dart';

import 'package:flutter_sqlite/model/music.dart';
import 'package:flutter_sqlite/screens/album_screen.dart';
import 'package:flutter_sqlite/screens/categorys_screen.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';
import 'package:flutter_sqlite/widgets/show_modal_bottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var isLoading = false;
  var db = MusicOperation();
  List<String> Menu = ["Categorys", "Musics", "Albuns"];
  List<Music> _musics = [];

  _menuOptions(String options) {
    switch (options) {
      case "Categorias":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CategoryScreen()));
        break;

      case "Albuns":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Album()));
        break;
    }
  }

  String _titleController = "";
  String _descriptionController = "";

  void _showForm(var musicaId) async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _titleController = value;
                      });
                    },
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _descriptionController = value;
                      });
                    },
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (musicaId != null) {
                        try {
                          musicaId.title = _titleController;
                          musicaId.description = _descriptionController;
                          musicaId.data = DateTime.now().toString();
                          await db.updateMusic(musicaId);

                          _retrieveMusics();
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        try {
                          Music musica = Music(
                            _titleController,
                            _descriptionController,
                            DateTime.now().toString(),
                          );

                          await db.saveMusic(musica);
                          _retrieveMusics();
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: const Text('submit'),
                  )
                ],
              ),
            ));
  }

  _retrieveMusics() async {
    List musicasRecuperadas = await db.fetchMusics();

    List<Music> listaTemporaria = [];
    for (var item in musicasRecuperadas) {
      Music musica = Music.fromJson(item);
      listaTemporaria.add(musica);
    }

    setState(() {
      _musics = listaTemporaria;
    });
  }

  _removeMusic(int id) async {
    await db.removerMusica(id);
    _retrieveMusics();
  }

  FunctionUtils functionUtils = FunctionUtils();

  @override
  void initState() {
    super.initState();
    _retrieveMusics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Flutter Sqlite',
          actionsAppBar: Row(
            children: [
              PopupMenuButton<String>(
                onSelected: _menuOptions,
                itemBuilder: (context) {
                  return Menu.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList();
                },
              ),
            ],
          )),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _musics.length,
              itemBuilder: (context, index) {
                final musica = _musics[index];
                return CardWidget(index, musica);
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.theme,
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }

  CardWidget(int index, Music musica) {
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
                      Text('Musica - ${_musics[index].title}'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "descrição - ${_musics[index].description} - ${_musics[index].id}",
                        style: TextStyle(color: Colors.white),
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
                      onPressed: () => _showForm(musica),
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _removeMusic(_musics[index].id!);
                        }),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
