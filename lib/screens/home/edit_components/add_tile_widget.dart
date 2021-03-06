import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ravelinestores/models/section.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/models/section_item.dart';
import 'package:ravelinestores/screens/edit_product/components/image_source_sheet.dart';

class AddTileWidget extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImageSelected(File file) {
      //adicionat um novo item e setar imagem
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            //verificar tipo de dispositivo
            //verificar se dispositivo é ios ou android
            if (Platform.isAndroid)
              showModalBottomSheet(
                context: context,
                builder: (context) => ImageSourceSheet(
                  onImageSelected: onImageSelected,
                ),
              );
            else
              showCupertinoModalPopup(
                context: context,
                builder: (context) => ImageSourceSheet(
                  onImageSelected: onImageSelected,
                ),
              );
          },
          splashColor: Colors.blueAccent,
          child: Card(
            elevation: 1,
            shadowColor: Colors.white,
            color: Colors.white.withAlpha(100),
            child: Center(
              child: Icon(Icons.add_a_photo, color: Colors.white, size: 48),
            ),
          ),
        ),
      ),
    );
  }
}
