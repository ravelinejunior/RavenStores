import 'package:flutter/material.dart';
import 'package:ravelinestores/models/section.dart';
import 'package:ravelinestores/screens/home/components/item_tile.dart';
import 'package:ravelinestores/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  final Section section;
  const SectionList(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //cabeçalho
          SectionHeader(section),

          //carregar imagens
          SizedBox(
            height: 200.0,
            //para colocar espaçamento entre itens
            child: ListView.separated(
              //definir direção da lista
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //retornar imagem WIDGET
                return ItemTile(section.items[index]);
              },
              itemCount: section.items.length,
              separatorBuilder: (context, index) => const SizedBox(width: 4.0),
            ),
          ),
        ],
      ),
    );
  }
}
