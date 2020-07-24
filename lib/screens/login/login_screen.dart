import 'package:flutter/material.dart';
import 'package:ravelinestores/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  //keys para formulario
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        //COLUMN COLOCADO PARA DEPOIS ADIÇÃO DE IMAGEM DE LOGO ACIMA DO CARD
        child: Card(
          elevation: 15,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              //deixar como se fosse wrap content para nao ocupar toda a tela
              shrinkWrap: true,
              //fomularios de acesso
              children: <Widget>[
                //LOGIN WIDGET
                TextFormField(
                  //decoração
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (!emailValid(email)) return 'E-mail inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 26.0),
                //SENHA WIDGET
                TextFormField(
                  controller: senhaController,
                  //decoração
                  decoration: InputDecoration(
                    hintText: "Senha",
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.all_inclusive),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (senha) {
                    if (senha.isEmpty || senha.length < 6)
                      return 'Senha incorreta';
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                //ESQUECI MINHA SENHA WIDGET
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton.icon(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    splashColor: Colors.grey,
                    icon: Icon(Icons.edit),
                    label: Text("Esqueci minha senha"),
                  ),
                ),
                const SizedBox(height: 16.0),
                //BOTAO LOGAR WIDGET
                SizedBox(
                  height: 50.0,
                  child: RaisedButton.icon(
                    splashColor: Colors.blue,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      //valida campos dos formularios
                      if (formKey.currentState.validate()) {
                        print(emailController.text);
                        print(senhaController.text);
                      }
                    },
                    icon: Icon(Icons.business_center, color: Colors.white),
                    label: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
