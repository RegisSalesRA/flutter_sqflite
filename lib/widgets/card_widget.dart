import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import '../model/model.dart';

class CustomCardWidget extends StatelessWidget {
  final Music music;
  final Function(Music)? onDetails;
  final Function(Music)? onEdit;
  final Function(Music)? onDelete;
  final bool details;
  final List<Widget>? children;
  const CustomCardWidget(
      {Key? key,
      required this.music,
      required this.onDetails,
      required this.onEdit,
      required this.onDelete,
      required this.details,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        height: 100,
        margin: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Palette.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32)),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children!),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    details == true
                        ? Center(
                            child: IconButton(
                              icon: const Icon(Icons.assignment),
                              onPressed: () => onDetails!(music),
                            ),
                          )
                        : SizedBox(
                            child: Row(children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => onEdit!(music),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => onDelete!(music),
                              ),
                            ]),
                          )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
