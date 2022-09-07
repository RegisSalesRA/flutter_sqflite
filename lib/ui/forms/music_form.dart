import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';

import '../../model/music.dart';

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
      appBar: AppBar(title: Text("music form")),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _titleController = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Title'),
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
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
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
