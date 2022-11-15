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
  final formAlbum = GlobalKey<FormState>();
  final nameController = TextEditingController();

  Future<void> _onSave() async {
    if (formAlbum.currentState!.validate()) {
      widget.album == null
          ? await _databaseService.insertAlbum(
              Album(
                name: nameController.text,
                data: DateTime.now().toString(),
              ),
            )
          : await _databaseService.updateAlbum(Album(
              id: widget.album!.id!,
              name: nameController.text,
              data: DateTime.now().toString(),
            ));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.album != null) {
      nameController.text = widget.album!.name!;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
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
            child: Form(
              key: formAlbum,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormWidget(
                    hintText: 'Name',
                    controller: nameController,
                    icon: Icons.app_registration_sharp,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Name can not be null or empty";
                      }
                      return null;
                    },
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
      ),
    );
  }
}
