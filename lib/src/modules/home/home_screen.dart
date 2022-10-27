import 'package:flutter/material.dart';
import 'package:flutter_sqlite/config/config.dart';
import 'package:sqflite/utils/utils.dart';

import '../../../animations/animations.dart';
import '../../../data/database_service.dart';
import '../../../model/model.dart';

import '../../widgets/widgets.dart';
import '../../../helpers/helpers.dart';
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

  Future<List<Music>> _getMusics() async {
    return await _databaseService.musics();
  }

  Future<List<Category>> _getCategorys() async {
    return await _databaseService.categories();
  }

  @override
  void initState() {
    super.initState();
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
                              // Category Scroll Items
                              SizedBox(
                                height: size.height * 0.30,
                                width: double.infinity,
                                child: FutureBuilder<List<Category>>(
                                  future: _getCategorys(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        break;
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      case ConnectionState.active:
                                        break;
                                      case ConnectionState.done:
                                        if (snapshot.hasData &&
                                            !snapshot.hasError) {
                                          if (snapshot.data!.length != 0) {
                                            return Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Categories",
                                                    style: TextStyle(
                                                        color: Palette
                                                            .primaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "more",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .grey.shade400),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: size.height * 0.25,
                                                width: size.width,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final category =
                                                        snapshot.data![index];
                                                    return Column(children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15))),
                                                        height:
                                                            size.height * 0.22,
                                                        width: 150,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          child: Image.asset(
                                                            'assets/images/detailPageImage.png',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        category.name!,
                                                        style: TextStyle(
                                                            color: Palette
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      )
                                                    ]);
                                                  },
                                                ),
                                              )
                                            ]);
                                          } else {
                                            return Center(
                                              child: Text(
                                                  "Nenhuma categoria cadastrada!"),
                                            );
                                          }
                                        }
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                              // List Musics Items
                              SizedBox(
                                  height: size.height * 0.35,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: FutureBuilder<List<Music>>(
                                          future: _getMusics(),
                                          builder: (context, snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                                break;
                                              case ConnectionState.active:
                                                break;
                                              case ConnectionState.waiting:
                                                return CircularProgressIndicator();

                                              case ConnectionState.done:
                                                if (snapshot.hasData &&
                                                    !snapshot.hasError) {
                                                  if (snapshot.data!.length !=
                                                      0) {
                                                    return SizedBox(
                                                        height:
                                                            size.height * 0.45,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  SingleChildScrollView(
                                                                physics:
                                                                    const BouncingScrollPhysics(),
                                                                child: FutureBuilder<
                                                                        List<
                                                                            Music>>(
                                                                    future:
                                                                        _getMusics(),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return const Center(
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        );
                                                                      } else if (snapshot
                                                                              .hasData &&
                                                                          !snapshot
                                                                              .hasError) {
                                                                        return ListView
                                                                            .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          itemCount: snapshot
                                                                              .data!
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            final music =
                                                                                snapshot.data![index];
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
                                                                                                builder: (_) => DetailScreen(music: value),
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
                                                                                        style: Theme.of(context).textTheme.headline2,
                                                                                      )
                                                                                    ]));
                                                                          },
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                            color: Colors
                                                                                .red,
                                                                            height: size.height *
                                                                                0.35,
                                                                            child:
                                                                                const Center(child: Text("Nenhuma musica cadastrada")));
                                                                      }
                                                                    }),
                                                              ),
                                                            ),
                                                          ],
                                                        ));
                                                  } else {
                                                    return SizedBox(
                                                        height:
                                                            size.height * 0.35,
                                                        width: size.width,
                                                        child: Center(
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
                                  ))
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey.shade400,
                                  size: 25,
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                        builder: (_) => const AlbumScreen(),
                                      ))
                                      .then((_) => setState(() {})),
                                  child: Icon(
                                    Icons.album_rounded,
                                    color: Colors.grey.shade400,
                                    size: 25,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                        builder: (_) => const CategoryScreen(),
                                      ))
                                      .then((_) => setState(() {})),
                                  child: Icon(
                                    Icons.category_outlined,
                                    color: Colors.grey.shade400,
                                    size: 25,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                        builder: (_) => const MusicScreen(),
                                      ))
                                      .then((_) => setState(() {})),
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
            )));
  }
}
