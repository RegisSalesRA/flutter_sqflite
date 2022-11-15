import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';

import '../../../config/colors.dart';
import '../../../model/model.dart';
import '../../widgets/widgets.dart';

class FavoriteMusic extends StatefulWidget {
  const FavoriteMusic({Key? key}) : super(key: key);

  @override
  State<FavoriteMusic> createState() => _FavoriteMusicState();
}

class _FavoriteMusicState extends State<FavoriteMusic> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Music>> _getMusics() async {
    return await _databaseService.musicFavorite(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBarWidget(
            actions: const SizedBox(),
            title: 'Favorite Music',
            onTap: () => Navigator.of(context).pop(),
          ),
          body: FutureBuilder<List<Music>>(
              future: _getMusics(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData && !snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final music = snapshot.data![index];
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: Icon(
                                        Icons.music_note,
                                        color: Colors.grey.shade400,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        music.name!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ]),
                                InkWell(
                                  onTap: () {
                                    {
                                      {
                                        {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  DetailScreen(music: music),
                                            ),
                                          );
                                        }
                                      }
                                    } 
                                  },
                                  child: const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.assignment)),
                                )
                              ],
                            ));
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("Nenhum dado cadastrado"));
                }
              })),
    );
  }
}
