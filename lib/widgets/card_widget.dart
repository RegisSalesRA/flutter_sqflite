import 'package:flutter/material.dart';

import '../css/colors.dart';

class CustomCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback showModal;
  final VoidCallback deletarMusica;
  CustomCardWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.showModal,
      required this.deletarMusica})
      : super(key: key);

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        height: 100,
        margin: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColors.card,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32)),
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Musica - ${widget.title}'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "descrição - ${widget.description}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => widget.showModal(),
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => widget.deletarMusica()),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
