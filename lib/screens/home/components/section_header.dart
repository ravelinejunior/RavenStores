import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/managers/home_manager.dart';
import 'package:ravelinestores/models/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();
//edição dos nomes das seções
    if (homeManager.editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    labelText: 'Título',
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.all(8),
                    isDense: true,
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                  //salvar
                  onChanged: (value) => section.name = value,
                ),
              ),

              //remover icon
              CustomIconButton(
                iconData: Icons.remove,
                onTap: () {
                  homeManager.removeSection(section);
                },
                color: Colors.red,
              ),
            ],
          ),
          //verificar se existe erro
          if (section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 16),
              child: Text(
                section.error,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? 'Clicado ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
    }
  }
}
