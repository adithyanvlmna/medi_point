import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  final bool? isObscure;
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool? isText;
  final bool? isSufix;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool isRead;
  final VoidCallback? onTap;
  final bool? isStyle;
  final bool? isSufixColor;
  final int? maxLines;
  final int? maxLength;
  final bool? isFormatter;
  final Function(String)? onChanged;
  final bool? isHalf;

  final String? Function(String?)? validator;

  const CommonTextField({
    this.isObscure = false,
    this.maxLength,
    this.isRead = false,
    this.isHalf = false,
    this.onTap,
    super.key,
    this.isText = false,
    this.isSufix,
    this.suffixIcon,
    this.onSuffixTap,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isStyle,
    this.isSufixColor = false,
    this.validator,
    this.maxLines,
    this.onChanged,
    this.isFormatter = false,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late FocusNode _focusNode;
  bool? obScureText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    obScureText = widget.isObscure;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder boreder(Color color) => OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10),
    );

    return TextFormField(
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: widget.maxLines,
      validator: widget.validator,
      style:
          widget.isStyle == true
              ? TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize:
                    widget.isHalf == true && widget.controller.text.length > 20
                        ? 10
                        : 14,
              )
              : TextStyle(
                color: Colors.black,
                fontSize:
                    widget.isHalf == true && widget.controller.text.length > 20
                        ? 10
                        : 14,
              ),
      onTap: widget.onTap,
      readOnly: widget.isRead,
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      cursorColor: Colors.black,
      inputFormatters:
          widget.isFormatter == true
              ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))]
              : widget.keyboardType == TextInputType.phone
              ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
              : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 248, 247, 247),
        errorMaxLines: 2,
        prefixIcon:
            widget.prefixIcon != null
                ? Icon(
                  widget.prefixIcon,
                  color: _focusNode.hasFocus ? Colors.black : Colors.grey,
                )
                : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: _focusNode.hasFocus ? Colors.black : Colors.grey,
          fontSize: 16,
        ),
        border: boreder(Colors.black),
        errorBorder: boreder(Colors.red),
        focusedErrorBorder: boreder(Colors.black),
        focusedBorder: boreder(Colors.black),
        enabledBorder: boreder(Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        suffixIcon:
            widget.isSufix == true
                ? IconButton(
                  onPressed: widget.onSuffixTap,
                  icon: Icon(
                    widget.suffixIcon,
                    color: _focusNode.hasFocus ? Colors.black : Colors.grey,
                  ),
                )
                : (widget.suffixIcon != null && widget.isSufix == null)
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.grey.shade400,
                    ),
                    GestureDetector(
                      onTap: widget.onSuffixTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(widget.suffixIcon, color: Colors.grey),
                      ),
                    ),
                  ],
                )
                : null,
      ),
    );
  }
}
