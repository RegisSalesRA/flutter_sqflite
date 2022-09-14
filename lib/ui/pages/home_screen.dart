// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';
import 'package:flutter_sqlite/model/model.dart';
import 'package:flutter_sqlite/ui/pages/pages.dart';
import 'package:flutter_sqlite/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var isLoading = false;
  List<String> Menu = ["Categorys", "Musics", "Albuns"];
  final DatabaseService _databaseService = DatabaseService();

  _menuOptions(String options) {
    switch (options) {
      case "Musics":
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (_) => const MusicScreen(),
            ))
            .then((_) => setState(() {}));
        break;

      case "Categorias":
        break;

      case "Albuns":
        break;
    }
  }

  Future<List<Music>> _getMusics() async {
    return await _databaseService.musics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: 'Flutter Sqflite',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Pesquise musica aqui...",
                prefixIcon: Icon(
                  Icons.search,
                  size: 21,
                ),
              ),
            ),
          ),
          Expanded(
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
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final music = snapshot.data![index];
                          return CustomCardWidget(
                            music: music,
                            onDetails: (value) {
                              {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            DetailScreen(music: value),
                                      ),
                                    )
                                    .then((_) => setState(() {}));
                              }
                            },
                            onDelete: null,
                            onEdit: null,
                            details: true,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text("Nenhum dado cadastrado"));
                  }
                }),
          )
        ],
      ),
    );
  }
}
