import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  TextInputField({
    Key? key,
    required this.icon,
    required this.hint,
    this.inputType,
    this.inputAction,
    this.maxLines,
    this.onChangeCallback,
    this.onEndCallback,
    this.initVal,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  TextInputType? inputType;
  TextInputAction? inputAction;
  int? maxLines;
  final String? initVal;
  final void Function(String value)? onChangeCallback;
  final void Function()? onEndCallback;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextFormField(
            initialValue: widget.initVal,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: widget.icon == null
                  ? const EdgeInsets.symmetric(horizontal: 15.0)
                  : null,
              prefixIcon: widget.icon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(
                        widget.icon,
                        size: 20,
                        color: Colors.white,
                      ))
                  : null,
              hintText: widget.hint,
              hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            onChanged: (value) => {widget.onChangeCallback!(value)},
            onEditingComplete: () => {widget.onEndCallback!()},
            maxLines: widget.maxLines,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
          ),
        ),
      ),
    );
  }
}
