import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/models/address.dart';

import 'address_input_field.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorButton = const Color.fromARGB(255, 46, 130, 200);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Consumer<CartManager>(
          builder: (contextOut, cartManager, childOut) {
            final address = cartManager.address ?? Address();

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Endereço de Entrega',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),

                  //CAMPO DE ALOCAÇÃO DE CEP WIDGET
                  CepInputField(address),
                  AddressInputField(address),
                  SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
