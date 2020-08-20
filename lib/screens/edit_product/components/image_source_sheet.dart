import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //verificar tipo de dispositivo
    if (Platform.isAndroid)
      return BottomSheet(
        elevation: 10,
        onClosing: () {},
        builder: (context) => Card(
          color: Colors.blue,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Text(
                  'Escolha a origem da foto',
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),

              Divider(color: Colors.grey),
              //botão de camera widget
              FlatButton.icon(
                splashColor: Colors.indigo,
                onPressed: () {},
                icon: Icon(
                  Icons.camera_enhance,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                label: const Text('Câmera'),
              ),
              Divider(
                color: Colors.white,
              ),

              //botão de galeria widget
              FlatButton.icon(
                splashColor: Colors.indigoAccent,
                onPressed: () {},
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                label: const Text('Galeria'),
              ),
            ],
          ),
        ),
      );
    else
      return CupertinoActionSheet(
        title: const Text('Selecionar foto'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar')),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Galeria'),
          )
        ],
      );
  }
}
