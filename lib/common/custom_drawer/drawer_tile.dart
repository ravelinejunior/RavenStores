import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  //declarar icone por parametro pois ele se alterará de acordo com passagem de objeto
  const DrawerTile(this.iconData, this.title, this.page);
  final IconData iconData;
  final String title;
  //indentificador de paginas
  final int page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(page);
      },
      splashColor: Colors.red,
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
                color: Colors.grey[700],
              ),
            ),

            //TEXTO WIDGET
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
