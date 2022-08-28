import 'package:flutter/material.dart';
import 'package:flutter_sqlite/css/colors.dart';
import '../widgets/appbar_widget.dart';

class Album extends StatefulWidget {
  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
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
          print("Not Albums");
        },
      ),
      appBar: MyAppBar(
        title: "Albums",
        actionsAppBar: Container(),
      ),
      body: Center(child: Text("Albuns")),
    );
  }
}
