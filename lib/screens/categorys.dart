import 'package:flutter/material.dart';
import 'package:flutter_sqlite/css/colors.dart';
import 'package:flutter_sqlite/widgets/appbar_widget.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.theme,
        child: Icon(
          Icons.add,
          color: CustomColors.textColor,
        ),
        onPressed: () {
          print("");
        },
      ),
      appBar: MyAppBar(
        title: "Not categories",
        actionsAppBar: Container(),
      ),
      body: Center(child: Text("")),
    );
  }
}
