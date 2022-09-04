import 'package:flutter/material.dart';
import 'package:flutter_sqlite/css/colors.dart';
import 'package:flutter_sqlite/data/music_operation.dart';

import 'package:flutter_sqlite/model/music.dart';
import 'package:flutter_sqlite/screens/album_screen.dart';
import 'package:flutter_sqlite/screens/categorys_screen.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';
import 'package:flutter_sqlite/widgets/card_widget.dart';
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

  void showForm(var musicaId) async {
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

  removeMusic(int id) async {
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
                return CustomCardWidget(
                    title: _musics[index].title!,
                    description: _musics[index].description!,
                    showModal: () {
                      showForm(musica);
                    },
                    deletarMusica: () {
                      removeMusic(_musics[index].id!);
                    });
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.theme,
        child: const Icon(Icons.add),
        onPressed: () => showForm(null),
      ),
    );
  }
}
