import 'package:flutter/material.dart';
import 'package:flutter_sqlite/src/widgets/widgets.dart';
import '../../../config/config.dart';
import '../../../data/database_service.dart';
import '../../../model/model.dart';

class DetailScreen extends StatefulWidget {
  final Music music;
  const DetailScreen({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final bool isLoading = false;
  final DatabaseService _databaseService = DatabaseService();

  Category categoriaMusica = Category();
  Album albumMusica = Album();

  Future categoryById() async {
    if (widget.music.categoryId != 0) {
      var data = await _databaseService.category(widget.music.categoryId);
      setState(() {
        categoriaMusica = data;
      });
    }
    return null;
  }

  Future albumById() async {
    if (widget.music.albumId != 0) {
      var data = await _databaseService.album(widget.music.albumId);
      setState(() {
        albumMusica = data;
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    categoryById();
    albumById();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.assignment,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    widget.music.albumId != 0
                        ? albumMusica.name.toString()
                        : "Nenhum album",
                  ),
                  content: Text(widget.music.description!),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Icon(Icons.cancel),
                    ),
                  ]),
            );
          },
        ),
        appBar: AppBarWidget(
          title: 'Details',
          onTap: () => Navigator.of(context).pop(),
          actions: widget.music.isFavorite == 1
              ? const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.favorite, color: Colors.red))
              : Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.grey.shade400,
                  ),
                ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: size.height * 0.05,
              bottom: 100,
              right: 0,
              left: 0,
              child: Container(
                height: size.height * 0.50,
                padding: const EdgeInsets.all(20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/detailPageImage.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.40,
              right: 30,
              bottom: 0,
              left: 30,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: size.width,
                            height: size.height * 0.40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                            ),
                            child: Column(children: [
                              Center(
                                  child: Text(
                                widget.music.categoryId != 0
                                    ? " ${categoriaMusica.name.toString()} "
                                    : "Nenhuma categoria",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Palette.primaryColorDark),
                              )),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    widget.music.description!,
                                    style: const TextStyle(
                                        color: Palette.primaryColorDark),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
