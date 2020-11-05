import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/screens/checkout/components/card_back.dart';
import 'package:ravelinestores/screens/checkout/components/card_front.dart';

class CreditCardWidget extends StatelessWidget {
  final GlobalKey<FlipCardState> _flipKey = GlobalKey<FlipCardState>();
  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: _flipKey,
            direction: FlipDirection.HORIZONTAL,
            speed: 1000,
            front: CardFront(
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finished: () {
                _flipKey.currentState.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
              cvvFocus: cvvFocus,
            ),
            flipOnTouch: false,
          ),
          FlatButton.icon(
            onPressed: () {
              _flipKey.currentState.toggleCard();
            },
            icon: Icon(Icons.swap_horizontal_circle),
            label: const Text('Virar Cartão'),
            textColor: Colors.white,
            splashColor: Colors.lightBlueAccent,
            padding: const EdgeInsets.all(8),
          )
        ],
      ),
    );
  }
}
