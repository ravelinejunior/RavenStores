import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/models/page_manager.dart';

class DrawerTile extends StatelessWidget {
  //declarar icone por parametro pois ele se alterará de acordo com passagem de objeto
  const DrawerTile(this.iconData, this.title, this.page);
  final IconData iconData;
  final String title;
  //indentificador de paginas
  final int page;

  @override
  Widget build(BuildContext context) {
//var de pagina atual
    final int curPage = context.watch<PageManager>().pageGo;

    //cor primaria
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        //passar para outra pagina
        context.read<PageManager>().setPage(page);
        print(page);
        print(curPage);
      },
      splashColor: primaryColor,
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            //ICONE WIDGET
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Icon(
                iconData,
                size: 32.0,
                //selecionar cor de acordo com pagina atual
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),

            //TEXTO WIDGET
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                //selecionar cor de acordo com pagina atual
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
