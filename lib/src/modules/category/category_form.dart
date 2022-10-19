// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database_service.dart';


import '../../../model/model.dart';
import '../../widgets/widgets.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;
  const CategoryForm({Key? key, this.category}) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final DatabaseService _databaseService = DatabaseService();

  final titleController = TextEditingController();

  Future<void> _onSave() async {
    widget.category == null
        ? // Add save code here
        await _databaseService.insertCategory(
            Category(
              name: titleController.text,
              data: DateTime.now().toString(),
            ),
          )
        : await _databaseService.updateCategory(Category(
            id: widget.category!.id!,
            name: titleController.text,
            data: DateTime.now().toString(),
          ));

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      titleController.text = widget.category!.name!;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category form")),
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
