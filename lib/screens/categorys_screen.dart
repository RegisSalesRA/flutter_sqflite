import 'package:flutter/material.dart';
import 'package:flutter_sqlite/css/colors.dart';
import 'package:flutter_sqlite/data/category_operation.dart';
import 'package:flutter_sqlite/screens/home_screen.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';
import 'package:flutter_sqlite/model/category.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var db = CategoryOperation();
  String _nameCategory = "";
  List<Category> categorias = [];
  var isLoading = false;

  void _showForm(var categoryId) async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _nameCategory = value;
                      });
                    },
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (categoryId != null) {
                        try {
                          categoryId.name = _nameCategory;
                          categoryId.data = DateTime.now().toString();
                          await db.atualizarCategoria(categoryId);
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        try {
                          Category category = Category(
                            _nameCategory,
                            DateTime.now().toString(),
                          );
                          await db.salvarCategory(category);
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: const Text('submit'),
                  )
                ],
              ),
            ));
  }

  _recuperarCategorias() async {
    List categoryRecuperadas = await db.recuperarCategory();

    List<Category> listaTemporaria = [];
    for (var item in categoryRecuperadas) {
      Category category = Category.fromJson(item);
      listaTemporaria.add(category);
    }

    setState(() {
      categorias = listaTemporaria;
    });
  }

  _removerCategoria(int id) async {
    await db.removerCategory(id);
    _recuperarCategorias();
  }

  @override
  void initState() {
    super.initState();
    _recuperarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.theme,
        child: Icon(
          Icons.add,
          color: CustomColors.textColor,
        ),
        onPressed: () => _showForm(null),
      ),
      appBar: MyAppBar(
        title: "Categories Page",
        actionsAppBar: Container(),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return Card(
                    color: CustomColors.theme,
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                        title: Text(
                            '${categorias[index].name} - ${categorias[index].id}'),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showForm(categoria),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _removerCategoria(categorias[index].id!);
                                  }),
                            ],
                          ),
                        )));
              }),
    );
  }
}
