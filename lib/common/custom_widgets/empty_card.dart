import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({@required this.title, @required this.iconData});
  final String title;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            iconData,
            color: Colors.white,
            size: 80,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 36),
            height: 66,
            child: RaisedButton.icon(
              elevation: 10,
              shape: StadiumBorder(),
              color: Color.fromARGB(255, 46, 125, 168),
              onPressed: () => Navigator.of(context).pushNamed('/products'),
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 34,
              ),
              label: const Text(
                'PRODUTOS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
