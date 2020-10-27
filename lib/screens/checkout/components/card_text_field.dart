import 'package:flutter/material.dart';

class CardTextField extends StatelessWidget {
  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  const CardTextField(
      {this.title, this.hint, this.bold = false, this.textInputType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          TextFormField(
            cursorColor: Colors.white,
            cursorWidth: 2,
            style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white.withAlpha(100)),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
            ),
            keyboardType: textInputType,
          ),
        ],
      ),
    );
  }
}
