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
                                /*
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
                         */
                                SizedBox(
                                    height: size.height * 0.35,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: FutureBuilder<List<Music>>(
                                            future: _getMusics(),
                                            builder: (context, snapshot) {
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.none:
                                                  break;
                                                case ConnectionState.active:
                                                  break;
                                                case ConnectionState.waiting:
                                                  return const SizedBox();

                                                case ConnectionState.done:
                                                  if (snapshot.hasData &&
                                                      !snapshot.hasError) {
                                                    if (snapshot
                                                        .data!.isNotEmpty) {
                                                      return SizedBox(
                                                          height: size.height *
                                                              0.45,
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  physics:
                                                                      const BouncingScrollPhysics(),
                                                                  child: ListView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      final music =
                                                                          snapshot
                                                                              .data![index];
                                                                      return snapshot
                                                                              .data![index]
                                                                              .name
                                                                              .toString()
                                                                              .toLowerCase()
                                                                              .contains(buscarMusicas)
                                                                          ? GestureDetector(
                                                                              onTap: () async {
                                                                                if (music.isFavorite == "true") {
                                                                                  await _databaseService.updateMusicFavorite(
                                                                                    "false",
                                                                                    music.id!,
                                                                                  );
                                                                                  setState(() {});
                                                                                } else {
                                                                                  await _databaseService.updateMusicFavorite("true", music.id!);
                                                                                  setState(() {});
                                                                                }
                                                                              },
                                                                              child: CustomCardWidget(
                                                                                  music: music,
                                                                                  onDetails: (value) {
                                                                                    {
                                                                                      {
                                                                                        {
                                                                                          closeKeyboard(context);
                                                                                          Navigator.of(context)
                                                                                              .push(
                                                                                                MaterialPageRoute(
                                                                                                  builder: (_) => DetailScreen(music: value),
                                                                                                ),
                                                                                              )
                                                                                              .then((_) => setState(() {}));
                                                                                        }
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  onDelete: null,
                                                                                  onEdit: null,
                                                                                  details: true,
                                                                                  children: [
                                                                                    Text(
                                                                                      music.name.toString(),
                                                                                      style: Theme.of(context).textTheme.headline2,
                                                                                    )
                                                                                  ]),
                                                                            )
                                                                          : Container();
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                                    } else {
                                                      return SizedBox(
                                                          height: size.height *
                                                              0.35,
                                                          width: size.width,
                                                          child: const Center(
                                                            child: Text(
                                                                "Nenhuma musica cadastrada!"),
                                                          ));
                                                    }
                                                  }
                                              }
                                              return Container();
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
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
