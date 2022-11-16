import 'package:flutter/material.dart';

import '../../../data/database_service.dart';

import '../../../helpers/helpers.dart';
import '../../../model/model.dart';
import '../../widgets/widgets.dart';

import '../album/album_screen.dart';
import '../category/category_screen.dart';
import '../favorite/favorite_screen.dart';
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
  final loading = ValueNotifier(false);
  ValueNotifier<List<Music>> musicFavorite = ValueNotifier<List<Music>>([]);
  String buscarMusicas = "";
  List<Music> futureListMusics2 = [];
  ValueNotifier<bool> valueNotifier = ValueNotifier(false);

  Future<List<Music>> _getMusics() async {
    return await _databaseService.musics();
  }

  Future<void> getMusicsFavorite() async {
    var request = await _databaseService.musics();
    musicFavorite.value = [...request];
  }

  Future<List<Category>> _getCategorys() async {
    return await _databaseService.categories();
  }

  @override
  void initState() {
    super.initState();
    futureListMusics = _getMusics();
    futureListCategorys = _getCategorys();
    getMusicsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: const AppBarWidget(
              title: "Home Page",
              onTap: null,
              actions: SizedBox(),
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
                                // Music Widget Scroll Items
                                MusicWidget(
                                  buscarMusicas: buscarMusicas,
                                  size: size.height * 0.35,
                                  databaseService: _databaseService,
                                  musicFavorite: musicFavorite,
                                )
                              ],
                            ),
                            // Actions Pages Buttons
                            NavigatorBottomBarWidget(
                              context: context,
                              size: size.height * 0.10,
                              onTapFavorite: () {
                                closeKeyboard(context);
                                searchController.clear();
                                setState(() {
                                  buscarMusicas = "";
                                });
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                      builder: (_) => const FavoriteMusic(),
                                    ))
                                    .then((_) => setState(() {}));
                              },
                              onTapAlbum: () {
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
                              onTapCategory: () {
                                closeKeyboard(context);
                                searchController.clear();
                                setState(() {
                                  buscarMusicas = "";
                                });
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                      builder: (_) => const CategoryScreen(),
                                    ))
                                    .then((_) => setState(() {}));
                              },
                              onTapMusic: () {
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
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            )));
  }
}
