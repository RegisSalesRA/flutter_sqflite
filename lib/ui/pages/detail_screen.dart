import 'package:flutter/material.dart';
import '../../model/model.dart';
import '../../widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  final Music music;
  const DetailScreen({Key? key, required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppBarWidget(title: "Detail Screen", actionsAppBar: SizedBox()),
      body: Center(child: Text("Detalhes Screen: ${music.id}")),
    );
  }
}
