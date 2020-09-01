import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/home_manager.dart';
import 'package:ravelinestores/models/section.dart';
import 'package:ravelinestores/screens/home/components/item_tile.dart';
import 'package:ravelinestores/screens/home/components/section_header.dart';
import 'package:ravelinestores/screens/home/edit_components/add_tile_widget.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;
  const SectionStaggered(this.section);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //cabeçalho
            SectionHeader(),
            Consumer<Section>(
              builder: (context, section, child) {
                return //criar a view customizada
                    StaggeredGridView.countBuilder(
                  //scrollar
                  physics: const NeverScrollableScrollPhysics(),
                  //delimitar tamanho
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  //itens na horizontal
                  crossAxisCount: 4,
                  itemCount: homeManager.editing
                      ? section.items.length + 1
                      : section.items.length,
                  itemBuilder: (context, index) {
                    //imagens Widget
                    if (index < section.items.length)
                      return ItemTile(section.items[index]);
                    else
                      return AddTileWidget();
                  },
                  //colocação dos tamanhos dos itens e imagens
                  staggeredTileBuilder: (index) =>
                      //verificar se numero é impar ou par
                      StaggeredTile.count(2, index.isEven ? 2 : 1.5),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
