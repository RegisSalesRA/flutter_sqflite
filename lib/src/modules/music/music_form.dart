// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';

import '../../../config/config.dart';
import '../../../model/model.dart';
import '../../widgets/widgets.dart';

class MusicScreenForm extends StatefulWidget {
  final Music? music;
  const MusicScreenForm({Key? key, this.music}) : super(key: key);

  @override
  State<MusicScreenForm> createState() => _MusicScreenFormState();
}

class _MusicScreenFormState extends State<MusicScreenForm> {
  final DatabaseService _databaseService = DatabaseService();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final choice = TextEditingController();

  late Future<List<Category>> categoriesList;

  Future<List<Category>> _getCategory() async {
    return await _databaseService.categories();
  }

  Future<void> _onSave() async {
    widget.music == null
        ? // Add save code here
        await _databaseService.insertMusic(
            Music(
              title: titleController.text,
              description: choice.text,
              data: DateTime.now().toString(),
            ),
          )
        : await _databaseService.updateMusic(Music(
            id: widget.music!.id!,
            title: titleController.text,
            description: choice.text,
            data: DateTime.now().toString(),
          ));

    Navigator.pop(context);
  }

  List<Map<String, dynamic>> categoriaMap = [
    {"name": "Categoria 1"},
    {"name": "Categoria 2"},
    {"name": "Categoria 3"},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.music != null) {
      titleController.text = widget.music!.title!;
      descriptionController.text = widget.music!.description!;
    }

    categoriesList = _getCategory();
    print(categoriesList);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          onTap: () => Navigator.of(context).pop(),
          title: 'Music Form',
          actions: const SizedBox(),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormWidget(
                  hintText: 'Title',
                  controller: titleController,
                  icon: Icons.app_registration_sharp,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormWidget(
                  hintText: 'Description',
                  controller: descriptionController,
                  icon: Icons.app_registration_sharp,
                ),
                const SizedBox(
                  height: 10,
                ),

                // Aqui

                FutureBuilder<List<Category>>(
                    future: categoriesList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData && !snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final music = snapshot.data![index];
                              return Text(
                                  snapshot.data![index].name.toString());
                            },
                          ),
                        );
                      } else {
                        return const Center(child: Text("Nenhuma Categoria"));
                      }
                    }),

                // end
                DropDownWidget(
                  dropdownItens: categoriaMap.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val["name"],
                        child: Text(val["name"]),
                      );
                    },
                  ).toList(),
                  hint: choice.text == ''
                      ? const Text(
                          'Select category',
                          style: TextStyle(
                              fontSize: 15, color: Palette.primaryColor),
                        )
                      : Text(
                          choice.text,
                          style: const TextStyle(color: Palette.primaryColor),
                        ),
                  getValue: (val) {
                    setState(
                      () {
                        choice.text = val!;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownWidget(
                  dropdownItens: categoriaMap.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val["name"],
                        child: Text(val["name"]),
                      );
                    },
                  ).toList(),
                  hint: choice.text == ''
                      ? const Text(
                          'Select album',
                          style: TextStyle(
                              fontSize: 15, color: Palette.primaryColor),
                        )
                      : Text(
                          choice.text,
                          style: const TextStyle(color: Palette.primaryColor),
                        ),
                  getValue: (val) {
                    setState(
                      () {
                        choice.text = val!;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _onSave,
                  child: const Text('submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
