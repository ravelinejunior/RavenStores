import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomDrawerHeader extends StatefulWidget {
  @override
  _CustomDrawerHeaderState createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  String url =
      "https://www.comercialdesafio.com.br/wp-content/uploads/2016/06/logo-comercial-desafio.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32.0, 16.0, 16.0, 8.0),
      height: 300.0,
      //usar o consumer devido a tela mudar quando não houver usuario logado
      child: Consumer<UserManager>(
        builder: (context, userManager, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //#TODO 2 verificar se irá funcionar
              FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url,
                  fit: BoxFit.fill,
                  height: 80),

              //NOME DA LOJA WIDGET

              Text(
                "Comercial Desafio LTDA",
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),

              // SizedBox(height: 8),

              //NOME Do Usuario WIDGET
              Text(
                //fazer condição para verificação de usuario logado
                "Olá ${userManager.user?.name ?? ', visitante.'}",
                overflow: TextOverflow.fade,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),

              //button widget
              InkWell(
                splashColor: Colors.blueAccent,
                child: Text(
                  //verificar se usuario está logado
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                onTap: () {
                  if (userManager.isLoggedIn) {
                    //#TODO: 3 logout
                    userManager.signOut();
                  } else
                    Navigator.of(context).pushNamed('/login');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
