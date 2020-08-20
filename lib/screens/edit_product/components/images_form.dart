import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:ravelinestores/screens/edit_product/components/image_source_sheet.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagesForm extends StatelessWidget {
  final Product product;
  const ImagesForm(this.product);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return FormField<List>(
      //passar imagens iniciais
      initialValue: product.images,
      builder: (state) {
        return //imagens carroussel
            AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: state.value.map<Widget>((image) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  //IMAGEM
                  //verificar se imagem é uma string ou um file
                  if (image is String)
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: image,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.file(
                      image as File,
                      fit: BoxFit.cover,
                    ),
                  //ICONE DO TOPO
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('Remover Imagem'),
                              elevation: 5,
                              scrollable: true,
                              actions: [
                                FlatButton(
                                  //REMOVER
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Não',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  //REMOVER
                                  onPressed: () {
                                    state.value.remove(image);
                                    //anunciar mudança no estado da tela
                                    state.didChange(state.value);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Sim',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                ],
              );
            }).toList()
              ..add(
                // adiciona outro widget
                Material(
                  color: Colors.grey[100],
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.blue,
                      size: 54,
                    ),
                    onPressed: () {
                      //verificar se dispositivo é ios ou android
                      if (Platform.isAndroid)
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ImageSourceSheet(),
                        );
                      else
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => ImageSourceSheet(),
                        );
                    },
                  ),
                ),
              ),
            dotBgColor: Colors.transparent,
            dotIncreasedColor: primaryColor,
            dotColor: Colors.blueAccent,
            dotSize: 6,
            boxFit: BoxFit.cover,
            autoplay: false,
            borderRadius: true,
          ),
        );
      },
    );
  }
}
