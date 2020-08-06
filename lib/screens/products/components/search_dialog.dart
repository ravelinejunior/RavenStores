import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  //receber string para caso usuario ja tenha digitado algo, fique no dialog
  final String initialText;
  const SearchDialog(this.initialText);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  splashColor: Colors.amber,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              onChanged: (text) {},
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        ),
      ],
    );
  }
}
