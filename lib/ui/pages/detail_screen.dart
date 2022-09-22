import 'package:flutter/material.dart';
import 'package:flutter_sqlite/helpers/helpers.dart';
//import 'package:sqflite/utils/utils.dart';
//import '../../helpers/helpers.dart';
import '../../model/model.dart';
//import '../../widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  final Music music;
  final bool isLoading = false;
  const DetailScreen({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Musica nome",
          style: TextStyle(color: Palette.primaryColorDark),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/backDetailPageImage.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/detailPageImage.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
              top: 250,
              right: 30,
              bottom: 0,
              left: 30,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: const Center(
                        child: Text(
                      "Album Dados Aqui",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Palette.primaryColorDark),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(children: const [
                                  Text(
                                    "Teste",
                                    style: TextStyle(
                                        color: Palette.primaryColorDark),
                                  )
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      )),
    );
  }
}

/*


                */