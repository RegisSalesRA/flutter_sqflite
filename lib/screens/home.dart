// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/sql_helper.dart';
import 'package:flutter_sqlite/model/musica.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = false;
  var _db = DataBaseFlutterSqlite();
  List<Musica> _musicas = [];

  String _titleController = "";
  String _descriptionController = "";

  void _showForm() async {
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
                      try {
                        Musica musica = Musica(_titleController,
                            _descriptionController, DateTime.now().toString());
                        int resultado = await _db.salvarMusica(musica);

                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const HomePage(),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('submit'),
                  )
                ],
              ),
            ));
  }

  void _showFormUpdate(Musica musica_id) async {
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
                      try {
                        musica_id.titulo = _titleController;
                        musica_id.descricao = _descriptionController;
                        musica_id.data = DateTime.now().toString();
                        int resultado = await _db.atualizarMusica(musica_id);

                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const HomePage(),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('submit'),
                  )
                ],
              ),
            ));
  }

  _recuperarMusicas() async {
    List musicasRecuperadas = await _db.recuperarMusicas();

    List<Musica> listaTemporaria = [];
    for (var item in musicasRecuperadas) {
      Musica musica = Musica.fromMap(item);
      listaTemporaria.add(musica);
    }

    setState(() {
      _musicas = listaTemporaria;
    });
  }

  _removerMusicas(int id) async {
    await _db.removerMusica(id);
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
      appBar: AppBar(
        title: const Text('Flutter sqlite'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _musicas.length,
              itemBuilder: (context, index) {
                final musica = _musicas[index];
                return Card(
                    color: Colors.greenAccent,
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
                                onPressed: () => _showFormUpdate(musica),
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
        child: const Icon(Icons.add),
        onPressed: () => _showForm(),
      ),
    );
  }
}
