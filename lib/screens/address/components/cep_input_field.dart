import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/models/address.dart';

class CepInputField extends StatelessWidget {
  CepInputField(this.address);
  final Address address;

  final colorButton = const Color.fromARGB(255, 46, 130, 200);
  TextEditingController _cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    if (address.zipCode == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'CEP',
                labelStyle: const TextStyle(fontWeight: FontWeight.w400),
                hintText: 'Ex: 123456-121',
                hintStyle: const TextStyle(color: Colors.black26),
                alignLabelWithHint: true,
              ),
              onTap: () {},
              keyboardType: TextInputType.numberWithOptions(),
              validator: (cep) {
                /* 
                verificar se cep é vazio
                verificar se cep é invalido
                como widget está dentro de um widget pai (Adress card), nao preciso utilizar key para validação
               */

                if (cep.isEmpty)
                  return 'Cep vazio';
                else if (cep.length != 10) return 'Digite um CEP válido!';
                return null;
              },
              inputFormatters: [
                //deixar usuario digitar apenas numeros
                WhitelistingTextInputFormatter.digitsOnly,

                CepInputFormatter(),
              ],
              controller: _cepController,
            ),
          ),
          Container(
            height: 44,
            child: RaisedButton.icon(
              onPressed: () async {
                if (Form.of(context).validate()) {
                  try {
                    await context
                        .read<CartManager>()
                        .getAddress(_cepController.text);
                  } catch (e) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        elevation: 10,
                        content: Card(
                          elevation: 0,
                          color: Colors.red,
                          margin: const EdgeInsets.all(8),
                          child: Text('$e'),
                        ),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              icon: Icon(Icons.local_shipping),
              label: const Text('Buscar Cep'),
              splashColor: Colors.lightBlue,
              textColor: Colors.white,
              shape: StadiumBorder(),
              color: colorButton,
              elevation: 10,
              disabledColor: colorButton.withAlpha(100),
            ),
          ),
        ],
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CEP: ${address.zipCode}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              color: color,
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
            ),
          ],
        ),
      );
  }
}
