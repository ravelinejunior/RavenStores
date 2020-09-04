import 'package:flutter/material.dart';
import 'package:ravelinestores/managers/home_manager.dart';
import 'package:ravelinestores/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget(this.homeManager);
  final HomeManager homeManager;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //lista
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton.icon(
              splashColor: Colors.white54,
              onPressed: () {
                homeManager.addSection(Section(type: 'list'));
                FocusScope.of(context).requestFocus(FocusNode());
              },
              icon: const Icon(Icons.list, color: Colors.white),
              textColor: Colors.white,
              label: const Text(
                'Adicionar Lista',
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),

        //grade
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton.icon(
              splashColor: Colors.lightBlue,
              onPressed: () {
                homeManager.addSection(Section(type: 'staggered'));
                FocusScope.of(context).requestFocus(FocusNode());
              },
              icon: const Icon(Icons.line_style, color: Colors.white),
              textColor: Colors.white,
              label: const Text(
                'Adicionar Grade',
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
