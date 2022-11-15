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
  final formCategory = GlobalKey<FormState>();
  final nameController = TextEditingController();

  Future<void> onSave() async {
    if (formCategory.currentState!.validate()) {
      widget.category == null
          ? await _databaseService.insertCategory(
              Category(
                name: nameController.text,
                data: DateTime.now().toString(),
              ),
            )
          : await _databaseService.updateCategory(Category(
              id: widget.category!.id!,
              name: nameController.text,
              data: DateTime.now().toString(),
            ));

              Navigator.pop(context);
    }

  
  }

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      nameController.text = widget.category!.name!;
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
          title: 'Category Form',
          onTap: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: formCategory,
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
                    onPressed: onSave,
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
