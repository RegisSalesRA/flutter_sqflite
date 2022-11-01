import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../model/model.dart';

 

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
      height: size.height * 0.30,
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
              if (snapshot.hasData &&
                  !snapshot.hasError) {
                if (snapshot.data!.isNotEmpty) {
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
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
                                  borderRadius: BorderRadius
                                      .all(Radius
                                          .circular(
                                              15))),
                              height: size.height *
                                  0.22,
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
                              style: const TextStyle(
                                  color: Palette
                                      .primaryColor,
                                  fontWeight:
                                      FontWeight
                                          .bold,
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
                  return const Center(
                    child: Text(
                        "Nenhuma categoria cadastrada!"),
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
