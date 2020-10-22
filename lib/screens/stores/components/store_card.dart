import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/models/store.dart';

class StoreCard extends StatelessWidget {
  final Store store;
  const StoreCard(this.store);
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromARGB(255, 46, 92, 138);
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          //imagem
          FadeInImage.assetNetwork(
            placeholder: 'assets/girlshopping.gif',
            image: store.image,
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
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
                      const Divider(
                        color: Colors.grey,
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
                      onTap: () {},
                      size: 28,
                    ),
                    CustomIconButton(
                      color: primaryColor,
                      iconData: Icons.contacts,
                      onTap: () {},
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
}
