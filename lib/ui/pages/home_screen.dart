import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';
import 'package:flutter_sqlite/model/music.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';

import 'music_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var isLoading = false;
  List<String> Menu = ["Categorys", "Musics", "Albuns"];
  List<Music> _musics = [];
  final DatabaseService _databaseService = DatabaseService();

  _menuOptions(String options) {
    switch (options) {
      case "Musics":
        print("Musics");
        break;

      case "Categorias":
        print("Categorias");
        break;

      case "Albuns":
        print("Albuns");
        break;
    }
  }

  Future<List<Music>> _getMusics() async {
    return await _databaseService.musics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Pesquise musica aqui...",
                    prefixIcon: Icon(
                      Icons.search,
                      size: 21,
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Music>>(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final music = snapshot.data![index];
                                return _buildCard(music, context);
                              },
                            ),
                          ));
                    } else {
                      return Container(
                        child: Center(child: Text("Nenhum dado cadastrado")),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (_) => MusicScreen(),
                ))
                .then((_) => setState(() {}));
          }),
    );
  }
}

Widget _buildCard(Music music, BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  music.title.toString(),
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  music.description.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
