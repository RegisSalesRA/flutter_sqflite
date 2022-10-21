import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';
import 'package:flutter_sqlite/src/modules/Album/Album_form.dart';

import '../../../config/colors.dart';
import '../../../model/model.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Album>> _getAlbum() async {
    return await _databaseService.albums();
  }

  Future<void> onAlbumDelete(Album Album) async {
    await _databaseService.deleteAlbum(Album.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Album Widget"),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15, top: 12),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (_) => const AlbumForm(),
                            ),
                          )
                          .then((_) => setState(() {}));
                    },
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 25),
                    )))
          ],
        ),
        body: SafeArea(
            child: FutureBuilder<List<Album>>(
                future: _getAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData && !snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final album = snapshot.data![index];
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  color: Colors.grey.shade400)),
                                          child: Padding(
                                            padding: EdgeInsets.all(1),
                                            child: Icon(
                                              Icons.album_outlined,
                                              color: Colors.grey.shade400,
                                              size: 26,
                                            ),
                                          )),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          album.name!,
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
                                    )
                                  ]),
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      AlbumForm(album: album),
                                                ),
                                              )
                                              .then((_) => setState(() {})),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () => {onAlbumDelete(album)},
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ])
                                ],
                              ));
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text("Nenhum dado cadastrado"));
                  }
                })));
  }
}
