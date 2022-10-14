import 'package:flutter/material.dart';
import 'package:flutter_sqlite/config/config.dart';
import '../../animations/animations.dart';
import '../../data/database_service.dart';
import '../../model/model.dart';
import '../../ui/pages/pages.dart';
import 'widgets/widgets.dart';
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
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  // Search Widget
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Pesquise musica aqui...",
                      suffixIcon: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Category Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                            color: Palette.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "more",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Category Scroll Items
                  SizedBox(
                    height: size.height * 0.20,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            height: 150,
                            width: 150,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: Image.asset(
                                'assets/images/detailPageImage.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Text(
                            "Categoria Album",
                            style: TextStyle(
                                color: Palette.primaryColor,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                        ]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // List Musics Items
                  Expanded(
                    child: FutureBuilder<List<Music>>(
                        future: _getMusics(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData && !snapshot.hasError) {
                            return ListView.builder(
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
                                                        DetailScreen(
                                                            music: value),
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          )
                                        ]));
                              },
                            );
                          } else {
                            return const Center(
                                child: Text("Nenhum dado cadastrado"));
                          }
                        }),
                  ),
                  // Actions Pages Buttons
                  Container(
                    height: 75,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Palette.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.grey.shade400,
                          size: 25,
                        ),
                        Icon(
                          Icons.album_rounded,
                          color: Colors.grey.shade400,
                          size: 25,
                        ),
                        Icon(
                          Icons.category_outlined,
                          color: Colors.grey.shade400,
                          size: 25,
                        ),
                        Icon(
                          Icons.music_note_outlined,
                          color: Colors.grey.shade400,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )));
  }
}
