import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
class CommonDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CommonDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = "Select an option",
    this.validator,
  });

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.items.contains(widget.value) ? widget.value : null,
      focusNode: _focusNode,
      isExpanded: true, // 👈 prevents horizontal overflow
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please select an option';
            }
            return null;
          },
      menuMaxHeight: widget.items.length * 48.0,
      icon: Icon(
        Icons.arrow_drop_down,
        color: _focusNode.hasFocus ? Colors.black : Colors.grey,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 248, 247, 247),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: _focusNode.hasFocus ? Colors.black : Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: _border(Colors.black),
        enabledBorder: _border(Colors.grey),
        focusedBorder: _border(Colors.black),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.black),
      ),
    );
  }
}


