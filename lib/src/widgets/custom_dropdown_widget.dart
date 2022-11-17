import 'package:flutter/material.dart';
import '../../config/config.dart';

class DropDownWidget extends StatefulWidget {
  final Function(dynamic) onChanged;
  final List<DropdownMenuItem<dynamic>>? items;
//  final dynamic value;
  final Widget? hint;

  const DropDownWidget(
      {Key? key,
      required this.onChanged,
      required this.items,
      //    required this.value,
      this.hint})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<dynamic>(
        hint: widget.hint,
        elevation: 16,
        style: const TextStyle(
          color: Palette.primaryColorLight,
        ),
        onChanged: widget.onChanged,
        items: widget.items,
      ),
    );
  }
}
