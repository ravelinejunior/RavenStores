import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.account_circle,
                color: Color.fromARGB(255, 46, 125, 168),
                size: 160,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Faça login para acessar seus pedidos!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 46, 125, 168),
                  ),
                  textAlign: TextAlign.center,
                ),
              ), /* 
              Container(
                height: 56,
                child: RaisedButton.icon(
                  shape: StadiumBorder(),
                  onPressed: () => Navigator.of(context).pushNamed('/login'),
                  icon: Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  label: const Text('LOGIN'),
                  textColor: Colors.white,
                  color: Color.fromARGB(255, 46, 125, 168),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
