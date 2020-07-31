import 'package:flutter/material.dart';
import 'package:ravelinestores/helpers/validators.dart';
import 'package:ravelinestores/models/user.dart';

class SignUpScreen extends StatelessWidget {
  //para acionar os validators, criar uma key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //chave snack bar
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController senhaConfirmController = TextEditingController();

  final User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar Conta",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                // NOME WIDGET
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Nome completo"),
                  validator: (text) {
                    if (text.isEmpty)
                      return "Campo obrigatório!";
                    else if (text.trim().split(' ').length <= 1) {
                      return 'Preencha com seu nome completo';
                    }
                    return null;
                  },
                  onSaved: (name) => user.name = name,
                ),
                const SizedBox(height: 16.0),

                //EMAIL WIDGET
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "E-mail"),
                  validator: (text) {
                    if (text.isEmpty)
                      return "Campo obrigatório!";
                    else if (!emailValid(text))
                      return 'Email inválido';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => user.email = email,
                ),
                const SizedBox(height: 16.0),

                //SENHA WIDGET
                TextFormField(
                  controller: senhaController,
                  decoration: const InputDecoration(hintText: "Senha"),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Campo obrigatório ou senha muito curta";
                    else
                      return null;
                  },
                  obscureText: true,
                  onSaved: (pass) => user.password = pass,
                ),
                const SizedBox(height: 16.0),
                //CONFIRMA SENHA WIDGET
                TextFormField(
                  controller: senhaConfirmController,
                  decoration:
                      const InputDecoration(hintText: "Confirmar senha"),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Campo obrigatório!";
                    else if (text != senhaController.text)
                      return 'Senhas não compatíveis!';
                    else
                      return null;
                  },
                  onSaved: (passConf) => user.passConf = passConf,
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                //BOTAO CADASTRAR WIDGET
                SizedBox(
                  height: 50.0,
                  child: RaisedButton(
                    splashColor: Colors.blue,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        //salvar dados
                        formKey.currentState.save();
                        if (user.password != user.passConf) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                              "Senhas não conferem, favor digitar senhas iguais!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          ));
                          return;
                        }
                        //enviar objeto para user manager

                      }
                    },
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
