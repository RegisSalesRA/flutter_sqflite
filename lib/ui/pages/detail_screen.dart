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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.assignment,
          color: Colors.white,
          size: 26,
        ),
        onPressed: () {},
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Palette.primaryColorDark),
        title: const Text(
          'Details',
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
            top: 25,
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
            top: 220,
            right: 30,
            bottom: 0,
            left: 30,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    color: Colors.grey.shade400,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height * 0.40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                          ),
                          child: Column(children: [
                            Center(
                                child: Text(
                              " '${music.title}' ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Palette.primaryColorDark),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Text(
                                  """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Iporem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
""",
                                  style: TextStyle(
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
      )),
    );
  }
}
