import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/cart_manager.dart';

class CepInputField extends StatelessWidget {
  final colorButton = const Color.fromARGB(255, 46, 130, 200);
  TextEditingController _cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              hintText: '30590-265',
              hintStyle: const TextStyle(color: Colors.black38),
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
            onPressed: () {
              if (Form.of(context).validate()) {
                context.read<CartManager>().getAddress(_cepController.text);
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
  }
}
