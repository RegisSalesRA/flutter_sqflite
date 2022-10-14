// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';

import '../../config/config.dart';
import '../../model/model.dart';
import '../widgets/widgets.dart';

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

  List<Map<String, dynamic>> devLevel = [
    {"name": "Junior"},
    {"name": "Pleno"},
    {"name": "Senior"},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.music != null) {
      titleController.text = widget.music!.title!;
      descriptionController.text = widget.music!.description!;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("music form")),
      body: SafeArea(
        child: SingleChildScrollView(
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
                // DropDown
                DropDownWidget(
                  dropdownItens: devLevel.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val["name"],
                        child: Text(val["name"]),
                      );
                    },
                  ).toList(),
                  hint: choice.text == ''
                      ? const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Select option',
                            style: TextStyle(
                                fontSize: 15, color: Palette.primaryColor),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            choice.text,
                            style: const TextStyle(color: Palette.primaryColor),
                          ),
                        ),
                  getValue: (val) {
                    setState(
                      () {
                        choice.text = val!;
                      },
                    );
                  },
                ),
                // DropDown
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
