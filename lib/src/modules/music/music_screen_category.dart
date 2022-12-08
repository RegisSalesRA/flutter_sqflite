import 'package:flutter/material.dart';
import 'package:flutter_sqlite/model/model.dart';

import '../../../animations/animations.dart';
import '../../../config/config.dart';
import '../../../data/database_service.dart';
import '../../widgets/widgets.dart';

class MusicScreenCategory extends StatefulWidget {
  final int categoryId;
  const MusicScreenCategory({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<MusicScreenCategory> createState() => _MusicScreenCategoryState();
}

class _MusicScreenCategoryState extends State<MusicScreenCategory> {
  final DatabaseService _databaseService = DatabaseService();
  var snapshot = ["categoria"];
  List<Music> listMusics = [];
  Future<List<Music>> _musicByCategoryId() async {
    var query = await _databaseService.musicByCategoryId(widget.categoryId);
    for (var item in query) {
      setState(() {
        listMusics.add(item);
      });
    }
    return query;
  }

  @override
  void initState() {
    super.initState();
    _musicByCategoryId();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBarWidget(
        title: "Music Screen Category",
        onTap: () => Navigator.of(context).pop(),
        actions: const SizedBox(),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: listMusics.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listMusics.length,
                    itemBuilder: (context, index) {
                      final music = listMusics[index];
                      return AnimatedFadedText(
                        direction: 1,
                        child: Container(
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
                                    child: Icon(
                                      Icons.category_outlined,
                                      color: Colors.grey.shade400,
                                      size: 25,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.65,
                                        child: Text(
                                          music.name!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.primaryColorLight),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                ]),
                                Row(mainAxisSize: MainAxisSize.min, children: [
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
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.assignment,
                                          color: Colors.grey.shade400,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ])
                              ],
                            )),
                      );
                    },
                  )
                : const Center(
                    child: Text("No music with this Category"),
                  ),
          )),
    ));
  }
}
