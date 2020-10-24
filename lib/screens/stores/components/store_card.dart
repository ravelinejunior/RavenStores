import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/models/store.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  final Store store;
  const StoreCard(this.store);

  Color colorForStatus(StoreStatus status) {
    switch (status) {
      case StoreStatus.closed:
        return Colors.red;
        break;
      case StoreStatus.closing:
        return Colors.orange;
        break;
      case StoreStatus.open:
        return Colors.green;
        break;

      default:
        return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromARGB(255, 46, 92, 138);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          Stack(
            children: [
              //imagem
              FadeInImage.assetNetwork(
                placeholder: 'assets/girlshopping.gif',
                image: store.image,
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
              ),

              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    store.statusText,
                    style: TextStyle(
                      color: colorForStatus(store.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Divider(
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
          ),

          //textos
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                //textos
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //nome loja
                      Text(
                        store.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      //endereço loja
                      Text(
                        store.addressText,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: primaryColor,
                        ),
                      ),

                      //horario de funcionamento
                      Text(
                        store.openingText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                //mapa e phone
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      color: primaryColor,
                      iconData: Icons.location_on,
                      onTap: () => openMap(context),
                      size: 28,
                    ),
                    CustomIconButton(
                      color: primaryColor,
                      iconData: Icons.contacts,
                      onTap: () => openPhone(context),
                      size: 28,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

//ligar
  Future<void> openPhone(BuildContext context) async {
    if (await canLaunch("tel:${store.cleanPhone}!!"))
      await launch("tel:${store.cleanPhone}");
    else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Este dispositivo não reconhece essa função!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          shape: StadiumBorder(),
          duration: const Duration(seconds: 3),
          elevation: 10,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> openMap(BuildContext context) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final map in availableMaps)
                ListTile(
                  shape: StadiumBorder(),
                  title: Text(map.mapName),
                  contentPadding: const EdgeInsets.all(16),
                  focusColor: Colors.lightBlue,
                  onTap: () {
                    map.showMarker(
                      coords: Coords(store.address.lat, store.address.long),
                      title: store.name,
                      description: store.addressText,
                    );
                    print(
                        "Lat e long ${store.address.lat}, ${store.address.long}");
                    Navigator.of(context).pop();
                  },
                  leading: Image(
                    image: map.icon,
                    width: 30,
                    height: 30,
                  ),
                ),
            ],
          ),
        ),
      );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Este dispositivo não reconhece essa função!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          shape: StadiumBorder(),
          duration: const Duration(seconds: 3),
          elevation: 10,
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
