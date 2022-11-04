import 'package:flutter/material.dart';
import '../../config/config.dart';

class DropDownWidget extends StatefulWidget {
  final Function(String?) getValue;
  final List<DropdownMenuItem<String>> dropdownItens;
  final Widget? hint;

  const DropDownWidget(
      {Key? key,
      required this.getValue,
      required this.dropdownItens,
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
      child: DropdownButtonFormField<String>(
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        ///        return 'Please select item';
        //       }
        //      return null;
        //    },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
        ),
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
        onChanged: widget.getValue,
        items: widget.dropdownItens,
      ),
    ));
  }
}
