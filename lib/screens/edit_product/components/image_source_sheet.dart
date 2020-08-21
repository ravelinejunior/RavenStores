import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({this.onImageSelected});

  final ImagePicker picker = ImagePicker();
  final Function(File) onImageSelected;

  //edição de imagem
  Future<void> editImage(String path, BuildContext context) async {
    final File croppedFile = await ImageCropper.cropImage(
      sourcePath: path,
      //aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar imagem',
        toolbarColor: Colors.grey[700],
        toolbarWidgetColor: Colors.white,
        statusBarColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey[700],
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Editar imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );

    if (croppedFile != null) {
      onImageSelected(croppedFile);
    }
  }

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
                onPressed: () async {
                  final PickedFile file =
                      await picker.getImage(source: ImageSource.camera);
                  //recupera file e passa imagem como parametro
                  editImage(file.path, context);
                },
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
                onPressed: () async {
                  final PickedFile file =
                      await picker.getImage(source: ImageSource.gallery);
                  //recupera file
                  editImage(file.path, context);
                },
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
