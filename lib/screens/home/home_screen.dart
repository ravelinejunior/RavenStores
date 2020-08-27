import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/managers/home_manager.dart';
import 'package:ravelinestores/managers/user_manager.dart';

import 'components/section_list.dart';
import 'components/section_staggered.dart';
import 'edit_components/add_section_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      //efeitos no body
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
                Color.fromARGB(255, 46, 92, 138),
                Color.fromARGB(255, 95, 168, 211),
                Color.fromARGB(255, 98, 182, 203),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                    splashColor: Colors.orange,
                  ),

                  //edição de tela de principal
                  Consumer2<UserManager, HomeManager>(
                    builder: (context, userManager, homeManager, child) {
                      if (userManager.adminEnabled) {
                        if (homeManager.editing) {
                          //entra no modo edição
                          return PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'Salvar') {
                                homeManager.saveEditing();
                              } else {
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (context) {
                              //mapear opções num widget
                              return ['Salvar', 'Descartar'].map(
                                (e) {
                                  return PopupMenuItem(
                                    child: Text(e),
                                    value: e,
                                  );
                                },
                              ).toList();
                            },
                          );
                        } else {
                          return IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: homeManager.enterEditing,
                          );
                        }
                      } else
                        return Container();
                    },
                  )
                ],
                elevation: 0,
                backgroundColor: Colors.transparent,
                snap: true,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: const Text('Comercial Desafio'),
                  centerTitle: true,
                ),
              ),
              //transforma widgets em widgets slivers
              Consumer<HomeManager>(
                builder: (context, homeManager, child) {
                  //definir uma lista dos filhos, transformar cada seção em um child
                  final List<Widget> children =
                      homeManager.sections.map<Widget>(
                    (section) {
                      switch (section.type) {
                        case 'staggered':
                          return SectionStaggered(section);
                        case 'list':
                          return SectionList(section);
                        default:
                          return Container();
                      }
                    },
                  ).toList();

                  //adicionar lista ou staggered fim da pagina
                  if (homeManager.editing)
                    children.add(AddSectionWidget(homeManager));

                  return SliverList(
                      delegate: SliverChildListDelegate(children));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
