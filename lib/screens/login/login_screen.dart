import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/helpers/validators.dart';
import 'package:ravelinestores/models/user.dart';
import 'package:ravelinestores/managers/user_manager.dart';

class LoginScreen extends StatefulWidget {
  //controllers
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController senhaController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        backgroundColor: Color.fromARGB(255, 46, 92, 138),
        centerTitle: true,
        //CADASTRAR WIDGET
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //vincular signup com o signup screen no main
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: Text(
              "Criar conta",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
                Color.fromARGB(255, 46, 92, 138),
                Color.fromARGB(255, 95, 168, 211),
                Color.fromARGB(255, 98, 182, 203),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Center(
            //COLUMN COLOCADO PARA DEPOIS ADIÇÃO DE IMAGEM DE LOGO ACIMA DO CARD
            child: Card(
              elevation: 15,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                //consumidor fica observando caso haja alteração nos filhos ele norifica
                child: Consumer<UserManager>(builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    //deixar como se fosse wrap content para nao ocupar toda a tela
                    shrinkWrap: true,
                    //fomularios de acesso
                    children: <Widget>[
                      //LOGIN WIDGET
                      TextFormField(
                        //decoração
                        controller: emailController,
                        //habilitar texto apenas se nao estiver carregando
                        enabled: !userManager.loading,
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
                        //habilitar texto apenas se nao estiver carregando
                        enabled: !userManager.loading,
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
                          onPressed: () {
                            if (emailController.text.isEmpty) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    "Insira seu email para recuperar senha",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                backgroundColor: Colors.white,
                                duration: Duration(seconds: 3),
                              ));
                            } else {
                              userManager.recoverPass(emailController.text);
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                  "Confira seu email (Lixo Eletrônico) e defina uma nova senha.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                                backgroundColor: Colors.blue,
                                duration: Duration(seconds: 4),
                              ));
                            }
                          },
                          splashColor: Theme.of(context).primaryColor,
                          icon: Icon(Icons.edit),
                          label: Text("Esqueci minha senha"),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      //BOTAO LOGAR WIDGET
                      SizedBox(
                        height: 50.0,
                        child: RaisedButton(
                          splashColor: Colors.blue,
                          color: Color.fromARGB(255, 46, 125, 168),
                          textColor: Colors.white,
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  //valida campos dos formularios
                                  if (formKey.currentState.validate()) {
                                    //receber acesso ao user manager
                                    userManager.signIn(
                                        user: User(
                                            email: emailController.text,
                                            password: senhaController.text),
                                        onFail: (e) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              "Falha ao logar: $e",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            backgroundColor: Colors.redAccent,
                                            duration: Duration(seconds: 4),
                                          ));
                                        },
                                        onSucess: () {
                                          // #TODO: FECHAR TELA DE LOGIN
                                          Navigator.of(context).pop();
                                        });
                                  }
                                },
                          child: userManager.loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text(
                                  "Entrar",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
