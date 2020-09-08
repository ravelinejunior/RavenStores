import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/models/address.dart';

class AddressInputField extends StatelessWidget {
  final Address address;
  const AddressInputField(this.address);
  @override
  Widget build(BuildContext context) {
    final colorButton = const Color.fromARGB(255, 46, 130, 200);
    String emptyValidator(String text) =>
        text.isEmpty ? "Campo Obrigatório" : null;

    return Consumer<CartManager>(
      builder: (context, cartManager, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Rua
            TextFormField(
              initialValue: address.street,
              decoration: const InputDecoration(
                isDense: true,
                labelText: "Rua/Avenida",
                hintText: "Rua Amural/Avenida Teresa Pors",
              ),
              validator: emptyValidator,
              onSaved: (text) => address.street = text,
            ),
            //numero e complemento
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: address.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: "Número",
                      hintText: "1322",
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    validator: emptyValidator,
                    onSaved: (text) => address.number = text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: address.complement,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: "Complemento",
                      hintText: "Apto 202",
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (text) => address.number = text,
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: address.disctrict,
              decoration: const InputDecoration(
                isDense: true,
                labelText: "Bairro",
                hintText: "Betânia",
              ),
              validator: emptyValidator,
              onSaved: (text) => address.disctrict = text,
            ),

            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    enabled: false,
                    initialValue: address.city,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: "Cidade",
                      hintText: "Belo Horizonte",
                    ),
                    validator: emptyValidator,
                    onSaved: (text) => address.city = text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    enabled: false,
                    textAlign: TextAlign.justify,
                    initialValue: address.state,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: "UF",
                      hintText: "MG",
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Campo obrigatório';
                      else if (value.length != 2)
                        return 'Campo inválido!';
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    onSaved: (text) => address.state = text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 56,
              child: RaisedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.attach_money),
                label: const Text('Calcular Frete'),
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
      },
    );
  }
}
