import 'package:flutter/material.dart';

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
      ),
    );
  }
}
