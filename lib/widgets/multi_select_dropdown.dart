import 'package:flutter/material.dart';

class CommonMultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) getLabel;
  final int Function(T) getId;
  final List<T> selectedItems;
  final String hintText;
  final void Function(List<T> selected) onSelectionChanged;

  const CommonMultiSelectDropdown({
    Key? key,
    required this.items,
    required this.getLabel,
    required this.getId,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.hintText = "Select options",
  }) : super(key: key);

  @override
  State<CommonMultiSelectDropdown<T>> createState() => _CommonMultiSelectDropdownState<T>();
}

class _CommonMultiSelectDropdownState<T> extends State<CommonMultiSelectDropdown<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = [...widget.selectedItems];
  }

  void _showMultiSelectDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(widget.hintText),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: widget.items.map((item) {
                    bool isSelected = _selectedItems.contains(item);
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(widget.getLabel(item)),
                      onChanged: (bool? selected) {
                        setStateDialog(() {
                          if (selected == true) {
                            _selectedItems.add(item);
                          } else {
                            _selectedItems.remove(item);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    widget.onSelectionChanged(_selectedItems);
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                )
              ],
            );
          },
        );
      },
    );
    setState(() {}); // To refresh selected items UI
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _selectedItems.isNotEmpty
        ? _selectedItems.map((e) => widget.getLabel(e)).join(', ')
        : widget.hintText;

    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(child: Text(displayText, style: const TextStyle(fontSize: 16))),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
