import 'package:flutter/material.dart';
import 'package:ravelinestores/managers/home_manager.dart';
import 'package:ravelinestores/models/section.dart';
import 'package:ravelinestores/screens/home/components/item_tile.dart';
import 'package:ravelinestores/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/screens/home/edit_components/add_tile_widget.dart';

class SectionList extends StatelessWidget {
  final Section section;
  const SectionList(this.section);

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
                return //carregar imagens
                    SizedBox(
                  height: 175.0,
                  //para colocar espaçamento entre itens
                  child: ListView.separated(
                    //definir direção da lista
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      //retornar imagem WIDGET
                      if (index < section.items.length)
                        return ItemTile(section.items[index]);
                      else
                        return AddTileWidget();
                    },
                    /* 
                 1 - caso esteja editando a tela, adicionar um item pra add foto
                 2 - verificar se indice clicado é menor que o tamanho final da lista, caso não seja, add um widget
                 */
                    itemCount: homeManager.editing
                        ? section.items.length + 1
                        : section.items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 4.0),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
