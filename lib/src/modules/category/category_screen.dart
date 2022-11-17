import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';
import 'package:flutter_sqlite/model/category.dart';
import 'package:flutter_sqlite/src/modules/category/category_form.dart';

import '../../../config/colors.dart';
import '../../../model/model.dart';
import '../../widgets/widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Category>> _getCategory() async {
    return await _databaseService.categories();
  }

  Future<void> oncategoryDelete(Category category) async {
    await _databaseService.deleteCategory(category.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) => const CategoryForm(),
                    ),
                  )
                  .then((_) => setState(() {}));
            },
            backgroundColor: Palette.primaryColorLight,
            child: const Icon(Icons.add),
          ),
          appBar: AppBarWidget(
            actions: const SizedBox(),
            title: 'Category Screen',
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          body: FutureBuilder<List<Category>>(
              future: _getCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isNotEmpty && !snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
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
                                        Icons.category_outlined,
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
                                        category.name!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.primaryColorLight),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                ]),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .push(
                                          MaterialPageRoute(
                                            builder: (_) => CategoryForm(
                                                category: category),
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
                                    onTap: () => {oncategoryDelete(category)},
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
                  return const Center(child: Text("No registered category"));
                }
              })),
    );
  }
}
