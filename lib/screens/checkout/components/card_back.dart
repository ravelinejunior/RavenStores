import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ravelinestores/screens/checkout/components/card_text_field.dart';

class CardBack extends StatelessWidget {
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
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height / 12,
              margin: const EdgeInsets.symmetric(vertical: 20),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Card(
                    margin: const EdgeInsets.only(left: 16),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.black54,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CardTextField(
                        hint: 'CVV:321',
                        inputFormaters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 3,
                        cardTextAlignment: TextAlign.end,
                        textInputType: TextInputType.number,
                        formFieldValidator: (value) {
                          if (value.isEmpty)
                            return "Campo obrigatório*";
                          else if (value.length != 3)
                            return "Digite 3 dígitos.";
                          else
                            return null;
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                )
              ],
            ),
            SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
