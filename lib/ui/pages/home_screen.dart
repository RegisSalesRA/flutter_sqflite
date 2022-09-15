import 'package:flutter/material.dart';
import '../../animations/animations.dart';
import '../../data/database_service.dart';
import '../../model/model.dart';
import '../../ui/pages/pages.dart';
import '../../widgets/widgets.dart';
import '../../helpers/helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> menu = ["Categorys", "Musics", "Albuns"];
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
                  return menu.map((String item) {
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
                          return AnimatedFadedText(
                              direction: 1,
                              child: CustomCardWidget(
                                  music: music,
                                  onDetails: (value) {
                                    {
                                      closeKeyboard(context);
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
                                  children: [
                                    Text(
                                      music.title.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    )
                                  ]));
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
