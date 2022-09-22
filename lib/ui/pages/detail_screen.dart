import 'package:flutter/material.dart';
import 'package:flutter_sqlite/helpers/helpers.dart';
import '../../model/model.dart';

class DetailScreen extends StatelessWidget {
  final Music music;
  final bool isLoading = false;
  const DetailScreen({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Palette.primaryColorDark),
        title: Text(
          music.title!,
          style: TextStyle(color: Palette.primaryColorDark),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ))
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            top: size.height * 0.15,
            bottom: size.height * 0.30,
            right: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/backDetailPageImage.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            bottom: size.height * 0.25,
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
                    color: Palette.greyShadeLight,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: size.height * 0.40,
                          decoration: BoxDecoration(
                            color: Palette.greyShadeLight,
                          ),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.greyShadeLight,
                              ),
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Center(
                                  child: Text(
                                " '${music.title}' ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Palette.primaryColorDark),
                              )),
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                music.description!,
                                style: const TextStyle(
                                    color: Palette.primaryColorDark),
                              ),
                            ))
                          ]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
