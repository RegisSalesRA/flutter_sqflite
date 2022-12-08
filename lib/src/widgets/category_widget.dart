import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../helpers/helpers.dart';
import '../../model/model.dart';
import '../modules/music/music_screen_category.dart';

class CategoryWidget extends StatelessWidget {
  final Size size;
  final Future<List<Category>> futureListCategorys;
  const CategoryWidget({
    Key? key,
    required this.size,
    required this.futureListCategorys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.24,
      width: double.infinity,
      child: FutureBuilder<List<Category>>(
        future: futureListCategorys,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData && !snapshot.hasError) {
                if (snapshot.data!.isNotEmpty) {
                  return Column(children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                          color: Palette.primaryColorLight,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: size.height * 0.20,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final category = snapshot.data![index];
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MusicScreenCategory(
                                                categoryId: category.id!,
                                              )),
                                    );
                                    closeKeyboard(context);
                                  },
                                  child: Container(
                                    height: size.height * 0.17,
                                    width: 115,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/detailPageImage.png'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.15,
                                  child: Text(
                                    category.name!,
                                    style: const TextStyle(
                                        color: Palette.primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ]);
                        },
                      ),
                    )
                  ]);
                } else {
                  return const Center(
                    child: Text("No registered category"),
                  );
                }
              }
          }
          return Container();
        },
      ),
    );
  }
}
