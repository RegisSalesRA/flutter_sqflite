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
    return DropdownButtonHideUnderline(
        child: ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<dynamic>(
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        ///        return 'Please select item';
        //       }
        //      return null;
        //    },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
        ),
      //  value: widget.value,
        hint: widget.hint,
        elevation: 16,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.primaryColor,
        ),
        style: const TextStyle(
          color: Palette.primaryColor,
        ),
        onChanged: widget.onChanged,
        items: widget.items,
      ),
    ));
  }
}
