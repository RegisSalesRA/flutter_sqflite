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
  final formMusic = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final lyricController = TextEditingController();
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

  Future<void> onSave() async {
    if (formMusic.currentState!.validate()) {
      widget.music == null
          ? await _databaseService.insertMusic(
              Music(
                name: nameController.text,
                description: descriptionController.text,
                lyric: lyricController.text,
                categoryId: categoryId,
                albumId: albumId,
                data: DateTime.now().toString(),
              ),
            )
          : await _databaseService.updateMusic(Music(
              id: widget.music!.id!,
              name: nameController.text,
              description: descriptionController.text,
              lyric: lyricController.text,
              categoryId: categoryId,
              albumId: albumId,
              data: DateTime.now().toString(),
            ));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.music != null) {
      nameController.text = widget.music!.name!;
      descriptionController.text = widget.music!.description!;
      lyricController.text = widget.music!.lyric!;
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
    lyricController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            child: Form(
              key: formMusic,
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
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Title can not be null or empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormWidget(
                    hintText: 'Description',
                    controller: descriptionController,
                    icon: Icons.app_registration_sharp,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Description can not be null or empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormWidget(
                    hintText: 'Lyric',
                    controller: lyricController,
                    icon: Icons.app_registration_sharp,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Lyric can not be null or empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Category>>(
                      future: categoriesList,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.waiting:
                            return const SizedBox();
                          case ConnectionState.done:
                            if (snapshot.data!.isNotEmpty &&
                                !snapshot.hasError) {
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
                                      child: SizedBox(
                                          width: size.width * 0.70,
                                          child: Text(
                                            value.name!,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    );
                                  },
                                ).toList(),
                                hint: categorySelected.text == ''
                                    ? SizedBox(
                                        width: size.width * 0.60,
                                        child: const Text(
                                          'Select category',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Palette.primaryColorLight),
                                        ),
                                      )
                                    : SizedBox(
                                        width: size.width * 0.60,
                                        child: Text(
                                          categorySelected.text,
                                          style: const TextStyle(
                                              color: Palette.primaryColorLight),
                                        ),
                                      ),
                              );
                            } else {
                              return const Center(
                                  child: Text("Register a category"));
                            }
                        }

                        return Container();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Album>>(
                      future: albumsList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.isNotEmpty &&
                            !snapshot.hasError) {
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
                                  child: SizedBox(
                                      width: size.width * 0.70,
                                      child: Text(
                                        value.name!,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                );
                              },
                            ).toList(),
                            hint: albumSelected.text == ''
                                ? SizedBox(
                                    width: size.width * 0.60,
                                    child: const Text(
                                      'Select album',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Palette.primaryColorLight),
                                    ),
                                  )
                                : SizedBox(
                                    width: size.width * 0.60,
                                    child: Text(
                                      albumSelected.text,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Palette.primaryColorLight),
                                    ),
                                  ),
                          );
                        } else {
                          return const Center(child: Text("Register a album"));
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
                    onPressed: onSave,
                    child: const Text('Save music'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
