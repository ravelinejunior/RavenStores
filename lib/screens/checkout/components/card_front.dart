import 'package:brasil_fields/formatter/cartao_bancario_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ravelinestores/screens/checkout/components/card_text_field.dart';

class CardFront extends StatelessWidget {
  MaskTextInputFormatter dateMask =
      MaskTextInputFormatter(mask: '!#/##', filter: {
    '#': RegExp('[0-9]'),
    '!': RegExp('[0-1]'),
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardTextField(
                    title: "Número",
                    hint: "0000-0000-0000-0000",
                    bold: true,
                    textInputType: TextInputType.number,
                    inputFormaters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CartaoBancarioInputFormatter(),
                    ],
                    formFieldValidator: (value) {
                      if (value.isEmpty)
                        return "Campo obrigatório*";
                      else if (value.length != 19)
                        return "Preencha os campos corretamente.";
                      else
                        return null;
                    },
                  ),
                  CardTextField(
                    title: "Validade",
                    hint: "11/27",
                    bold: true,
                    textInputType: TextInputType.number,
                    inputFormaters: [
                      FilteringTextInputFormatter.digitsOnly,
                      dateMask,
                    ],
                    formFieldValidator: (value) {
                      if (value.isEmpty)
                        return "Campo obrigatório*";
                      else if (value.length != 5)
                        return "Preencha todos os campos corretamente.";
                      else
                        return null;
                    },
                  ),
                  CardTextField(
                    title: "Nome",
                    hint: "TESTE DA SILVA SAURO",
                    bold: true,
                    textInputType: TextInputType.name,
                    formFieldValidator: (value) {
                      if (value.isEmpty)
                        return "Campo obrigatório*";
                      else
                        return null;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
