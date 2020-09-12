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
    final cartManager = context.watch<CartManager>();

    String emptyValidator(String text) =>
        text.isEmpty ? "Campo Obrigatório" : null;

    if (address.zipCode != null && cartManager.deliveryPrice == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Rua
          TextFormField(
            initialValue: address.street,
            decoration: const InputDecoration(
              isDense: true,
              labelText: "Rua/Avenida",
              hintText: "Ex:.Rua Amural/Avenida Teresa Pors",
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
                    hintText: "Ex:.1322",
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
                    hintText: "Ex:.Apto 202",
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (text) => address.complement = text,
                ),
              ),
            ],
          ),
          TextFormField(
            initialValue: address.district,
            decoration: const InputDecoration(
              isDense: true,
              labelText: "Bairro",
              hintText: "Ex:Betânia",
            ),
            validator: emptyValidator,
            onSaved: (text) => address.district = text,
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
                    hintText: "Ex:Belo Horizonte",
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
                    hintText: "Ex:MG",
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
          Consumer<CartManager>(
            builder: (contextOut, cartManager, childOut) {
              if (!cartManager.loading)
                return Container(
                  height: 56,
                  child: RaisedButton.icon(
                    onPressed: () async {
                      if (Form.of(context).validate()) {
                        Form.of(context).save();
                        try {
                          await context.read<CartManager>().setAddress(address);
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
                    icon: Icon(Icons.attach_money),
                    label: const Text(
                      'Calcular Frete',
                      style: const TextStyle(fontSize: 16),
                    ),
                    splashColor: Colors.lightBlue,
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                    color: colorButton,
                    elevation: 10,
                    disabledColor: colorButton.withAlpha(100),
                  ),
                );
              else
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(colorButton),
                  ),
                );
            },
          ),
        ],
      );
    else if (address.zipCode != null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.grey[400],
          ),
          Text(
            "${address.street}, ${address.number}\n${address.district}\n${address.city}-${address.state}",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
        ],
      );
    else
      return Container();
  }
}
