// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';

import '../../model/model.dart';

class MusicScreenForm extends StatefulWidget {
  final Music? music;
  const MusicScreenForm({Key? key, this.music}) : super(key: key);

  @override
  State<MusicScreenForm> createState() => _MusicScreenFormState();
}

class _MusicScreenFormState extends State<MusicScreenForm> {
  final DatabaseService _databaseService = DatabaseService();

  String _titleController = "";
  String _descriptionController = "";

  Future<void> _onSave() async {
    widget.music == null
        ? // Add save code here
        await _databaseService.insertMusic(
            Music(
              title: _titleController,
              description: _descriptionController,
              data: DateTime.now().toString(),
            ),
          )
        : await _databaseService.updateMusic(Music(
            id: widget.music!.id!,
            title: _titleController,
            description: _descriptionController,
            data: DateTime.now().toString(),
          ));

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.music != null) {
      _titleController = widget.music!.title!;
      _descriptionController = widget.music!.description!;
    }
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
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _titleController = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Title",
                    prefixIcon: Icon(
                      Icons.app_registration_sharp,
                      size: 21,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _descriptionController = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    prefixIcon: Icon(
                      Icons.app_registration_sharp,
                      size: 21,
                    ),
                  ),
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
