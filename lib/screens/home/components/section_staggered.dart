import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ravelinestores/models/section.dart';
import 'package:ravelinestores/screens/home/components/item_tile.dart';
import 'package:ravelinestores/screens/home/components/section_header.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;
  const SectionStaggered(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //cabeçalho
          SectionHeader(section),
          //criar a view customizada
          StaggeredGridView.countBuilder(
            //scrollar
            physics: const NeverScrollableScrollPhysics(),
            //delimitar tamanho
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            //itens na horizontal
            crossAxisCount: 4,
            itemCount: section.items.length,
            itemBuilder: (context, index) {
              //imagens Widget
              return ItemTile(section.items[index]);
            },
            //colocação dos tamanhos dos itens e imagens
            staggeredTileBuilder: (index) =>
                //verificar se numero é impar ou par
                StaggeredTile.count(2, index.isEven ? 2 : 1.5),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
        ],
      ),
    );
  }
}
