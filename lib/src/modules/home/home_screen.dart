import 'package:flutter/material.dart';
import 'package:flutter_sqlite/config/config.dart';
import 'package:flutter_sqlite/src/modules/home/widget/widget.dart';

import '../../../data/database_service.dart';

import '../../../helpers/helpers.dart';
import '../../../model/model.dart';
import '../../widgets/widgets.dart';

import '../album/album_screen.dart';
import '../category/category_screen.dart';
import '../music/music_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<Music>> futureListMusics;
  late Future<List<Category>> futureListCategorys;
  final searchController = TextEditingController();
  String buscarMusicas = "";

  Future<List<Music>> _getMusics() async {
    return await _databaseService.musics();
  }

  Future<List<Category>> _getCategorys() async {
    return await _databaseService.categories();
  }

  @override
  void initState() {
    super.initState();
    futureListMusics = _getMusics();
    futureListCategorys = _getCategorys();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                'Flutter Sqflite',
                style: TextStyle(color: Palette.primaryColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: size.height * 0.85,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Search Widget
                                TextField(
                                  controller: searchController,
                                  onChanged: (value) {
                                    return setState(() {
                                      buscarMusicas =
                                          value.toLowerCase().toString();
                                    });
                                  },
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
                                // Category Scroll Items
                                CategoryWidget(
                                    size: MediaQuery.of(context).size,
                                    futureListCategorys: futureListCategorys),
                                // List Musics Items
                                MusicWidget(
                                  size: MediaQuery.of(context).size,
                                  futureListMusics: futureListMusics,
                                  buscarMusicas: buscarMusicas,
                                  onDetails: (value) {
                                    {
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
                                    }
                                  },
                                )
                              ],
                            ),
                            // Actions Pages Buttons
                            Container(
                              height: size.height * 0.10,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Palette.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey.shade400,
                                    size: 25,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      closeKeyboard(context);
                                      searchController.clear();
                                      setState(() {
                                        buscarMusicas = "";
                                      });
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                            builder: (_) => const AlbumScreen(),
                                          ))
                                          .then((_) => setState(() {}));
                                    },
                                    child: Icon(
                                      Icons.album_rounded,
                                      color: Colors.grey.shade400,
                                      size: 25,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      closeKeyboard(context);
                                      searchController.clear();
                                      setState(() {
                                        buscarMusicas = "";
                                      });
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                            builder: (_) =>
                                                const CategoryScreen(),
                                          ))
                                          .then((_) => setState(() {}));
                                    },
                                    child: Icon(
                                      Icons.category_outlined,
                                      color: Colors.grey.shade400,
                                      size: 25,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      closeKeyboard(context);
                                      searchController.clear();
                                      setState(() {
                                        buscarMusicas = "";
                                      });
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                            builder: (_) => const MusicScreen(),
                                          ))
                                          .then((_) => setState(() {}));
                                    },
                                    child: Icon(
                                      Icons.music_note_outlined,
                                      color: Colors.grey.shade400,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            )));
  }
}
