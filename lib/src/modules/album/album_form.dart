// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';

import '../../../model/model.dart';
import '../../widgets/widgets.dart';

class AlbumForm extends StatefulWidget {
  final Album? album;
  const AlbumForm({Key? key, this.album}) : super(key: key);

  @override
  State<AlbumForm> createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  final DatabaseService _databaseService = DatabaseService();

  final titleController = TextEditingController();

  Future<void> _onSave() async {
    widget.album == null
        ? // Add save code here
        await _databaseService.insertAlbum(
            Album(
              name: titleController.text,
              data: DateTime.now().toString(),
            ),
          )
        : await _databaseService.updateAlbum(Album(
            id: widget.album!.id!,
            name: titleController.text,
            data: DateTime.now().toString(),
          ));

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.album != null) {
      titleController.text = widget.album!.name!;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          actions: const SizedBox(),
          title: 'Album Form',
          onTap: () => Navigator.of(context).pop(),
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
                  hintText: 'Name',
                  controller: titleController,
                  icon: Icons.app_registration_sharp,
                ),
                const SizedBox(
                  height: 10,
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
