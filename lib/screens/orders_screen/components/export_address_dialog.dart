import 'dart:io';
import 'package:flutter/material.dart';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:ravelinestores/models/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog(this.address);
  final Address address;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final styleText = TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
    return Screenshot(
      controller: screenshotController,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: Color.fromARGB(255, 46, 92, 138),
        title: Text(
          'Endereço de entrega',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(8),
          color: Color.fromARGB(255, 46, 92, 138),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: Colors.white.withAlpha(100),
                thickness: 1,
              ),
              Text(
                address.street,
                style: styleText,
              ),
              Divider(
                color: Colors.white.withAlpha(100),
                thickness: 1,
              ),
              Text(
                address.number,
                style: styleText,
              ),
              Divider(
                color: Colors.white.withAlpha(100),
                thickness: 1,
              ),
              if (address.complement != '')
                Text(
                  address.complement,
                  style: styleText,
                ),
              if (address.complement != '')
                Divider(
                  color: Colors.white.withAlpha(100),
                  thickness: 1,
                ),
              Text(
                address.district,
                style: styleText,
              ),
              Divider(
                color: Colors.white.withAlpha(100),
                thickness: 1,
              ),
              Text(
                '${address.city}/${address.state}',
                style: styleText,
              ),
              Divider(
                color: Colors.white.withAlpha(100),
                thickness: 1,
              ),
              Text(
                address.zipCode,
                style: styleText,
              ),
              Divider(
                color: Colors.white.withAlpha(100),
                thickness: 1,
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
        actions: [
          Center(
            child: FlatButton.icon(
              color: Color.fromARGB(255, 95, 168, 211),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              splashColor: Colors.lightBlue.withAlpha(100),
              onPressed: () async {
                try {
                  //salvar imagem na galeria
                  File file = await screenshotController.capture();
                  await GallerySaver.saveImage(file.path);
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text(
                        "Imagem exportada para galeria",
                      ),
                      elevation: 10,
                      contentPadding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      children: [
                        Column(
                          children: [
                            Divider(),
                            Text(
                              'Imagem exportada para galeria com endereço selecionado.\nVerifique sua galeria com o endereço do cliente.',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: FlatButton.icon(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.blue[800],
                                  size: 36,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                label: Text(
                                  "Fechar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  debugPrint('Error share Image: $e');
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.mobile_screen_share,
                color: Colors.white,
              ),
              label: Text(
                'Exportar',
                style: styleText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
