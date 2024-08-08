import 'package:emart/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:emart/consts/colors.dart';

class CustomField extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextEditingController controller;
  final bool isPass;

  const CustomField({
    Key? key,
    this.title,
    this.hint,
    required this.controller,
    this.isPass = false,
  }) : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title!,
          style: const TextStyle(
            color: redColor,
            fontFamily: semibold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: widget.isPass ? _obscureText : false,
          controller: widget.controller,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: widget.hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: redColor),
            ),
            suffixIcon: widget.isPass
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: redColor,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
          ),
        ),
      ],
    );
  }
}
