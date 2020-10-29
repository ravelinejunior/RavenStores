import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormaters;
  final FormFieldValidator<String> formFieldValidator;

  const CardTextField({
    this.title,
    this.hint,
    this.bold = false,
    this.textInputType,
    this.inputFormaters,
    this.formFieldValidator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        initialValue: '',
        validator: formFieldValidator,
        autovalidateMode: AutovalidateMode.always,
        builder: (state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    if (state.hasError)
                      Text(
                        '    ${state.errorText}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
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
                  inputFormatters: inputFormaters,
                  onChanged: (value) {
                    state.didChange(value);
                  },
                ),
              ],
            ),
          );
        });
  }
}
