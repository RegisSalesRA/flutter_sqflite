import 'package:flutter/material.dart';
import 'package:flutter_sqlite/css/colors.dart';
import 'package:flutter_sqlite/data/music_operation.dart';

import 'package:flutter_sqlite/model/musica.dart';
import 'package:flutter_sqlite/screens/album.dart';
import 'package:flutter_sqlite/screens/categorys.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var isLoading = false;
  var db = MusicOperation();
  List<String> Menu = ["Categorias", "Albuns"];
  List<Musica> _musicas = [];

  _menuOptions(String options) {
    switch (options) {
      case "Categorias":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Category()));
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
                          musicaId.titulo = _titleController;
                          musicaId.descricao = _descriptionController;
                          musicaId.data = DateTime.now().toString();
                          await db.atualizarMusica(musicaId);

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false);
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        try {
                          Musica musica = Musica(
                            _titleController,
                            _descriptionController,
                            DateTime.now().toString(),
                          );

                          await db.salvarMusica(musica);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false);
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

  _recuperarMusicas() async {
    List musicasRecuperadas = await db.recuperarMusicas();

    List<Musica> listaTemporaria = [];
    for (var item in musicasRecuperadas) {
      Musica musica = Musica.fromJson(item);
      listaTemporaria.add(musica);
    }

    setState(() {
      _musicas = listaTemporaria;
    });
  }

  _removerMusicas(int id) async {
    await db.removerMusica(id);
    _recuperarMusicas();
  }

  @override
  void initState() {
    super.initState();
    _recuperarMusicas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: 'Flutter Sqlite',
          actionsAppBar: Row(
            children: [
              InkWell(
                onTap: () {
                  print("None");
                },
                child: Icon(Icons.refresh),
              ),
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
              itemCount: _musicas.length,
              itemBuilder: (context, index) {
                final musica = _musicas[index];
                return Card(
                    color: Color.fromRGBO(105, 240, 174, 1),
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                        title: Text(_musicas[index].titulo.toString()),
                        subtitle: Text(_musicas[index].descricao.toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showForm(musica),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _removerMusicas(_musicas[index].id!);
                                  }),
                            ],
                          ),
                        )));
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.theme,
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
