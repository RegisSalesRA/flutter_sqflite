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
  // Controllers And Variables
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categorySelected = TextEditingController();
  final albumSelected = TextEditingController();
  int? categoryId = 0;
  int? albumId = 0;
  // Database
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<Category>> categoriesList;
  late Future<List<Album>> albumsList;

  Future<List<Category>> _getCategory() async {
    return await _databaseService.categories();
  }

  Future<List<Album>> _getAlbum() async {
    return await _databaseService.albums();
  }

  Future<void> _onSave() async {
    widget.music == null
        ? // Add save code here
        await _databaseService.insertMusic(
            Music(
              name: nameController.text,
              description: descriptionController.text,
              isFavorite: "false",
              categoryId: categoryId,
              albumId: albumId,
              data: DateTime.now().toString(),
            ),
          )
        : await _databaseService.updateMusic(Music(
            id: widget.music!.id!,
            name: nameController.text,
            description: descriptionController.text,
            categoryId: categoryId,
            albumId: albumId,
            data: DateTime.now().toString(),
          ));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.music != null) {
      nameController.text = widget.music!.name!;
      descriptionController.text = widget.music!.description!;
      categoryId = widget.music?.categoryId;
      albumId = widget.music?.albumId;
    }
    categoriesList = _getCategory();
    albumsList = _getAlbum();
  }

  @override
  void dispose() {
    nameController.dispose();
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
                  controller: nameController,
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
                FutureBuilder<List<Category>>(
                    future: categoriesList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData && !snapshot.hasError) {
                        return DropDownWidget(
                          onChanged: (value) {
                            setState(
                              () {
                                categorySelected.text = value.name;
                                categoryId = value.id;
                              },
                            );
                          },
                          items: snapshot.data!.map(
                            (Category value) {
                              return DropdownMenuItem<Category>(
                                value: value,
                                child: Text(value.name!),
                              );
                            },
                          ).toList(),
                          hint: categorySelected.text == ''
                              ? const Text(
                                  'Select category',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Palette.primaryColor),
                                )
                              : Text(
                                  categorySelected.text,
                                  style: const TextStyle(
                                      color: Palette.primaryColor),
                                ),
                        );
                      } else {
                        return const Center(child: Text("Nenhuma Categoria"));
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<List<Album>>(
                    future: albumsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData && !snapshot.hasError) {
                        return DropDownWidget(
                          onChanged: (value) {
                            setState(
                              () {
                                albumSelected.text = value.name;
                                albumId = value.id;
                              },
                            );
                          },
                          items: snapshot.data!.map(
                            (Album value) {
                              return DropdownMenuItem<Album>(
                                alignment: AlignmentDirectional.centerStart,
                                value: value,
                                child: Text(value.name!),
                              );
                            },
                          ).toList(),
                          hint: albumSelected.text == ''
                              ? const Text(
                                  'Select album',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Palette.primaryColor),
                                )
                              : Text(
                                  albumSelected.text,
                                  style: const TextStyle(
                                      color: Palette.primaryColor),
                                ),
                        );
                      } else {
                        return const Center(child: Text("Nenhum album"));
                      }
                    }),
                const SizedBox(
                  height: 10,
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
