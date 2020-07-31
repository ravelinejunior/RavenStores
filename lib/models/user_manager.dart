import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/helpers/firebase_errors.dart';
import 'package:ravelinestores/models/user.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
//tratar exceções

//pegar usuario logado
  UserManager() {
    _loadCurrentUser();
  }

  bool _loading = false;
  bool get loading => _loading;
  //set
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //metodo para autenticar usuarios
  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await Future.delayed(Duration(seconds: 4));

      //apos receber o resultado da operação, verificar os resultados
      this.user = result.user;

      onSucess();
    } on PlatformException catch (e) {
      print(getErrorString(e.code));
      onFail(getErrorString(e.code));
    }

    //metodo para verificar se ha algo carregando
    loading = false;
  }

  //AUTENTICAÇÃO DE CADASTRO USUARIO
  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;

    //como pode ocorrer exceções usar try catch
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      // this.user = result.user;
      //salvando id do usuario
      user.id = result.user.uid;

      //aguardar dados serem salvos
      await user.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> _loadCurrentUser() async {
    //retorna usuario logado
    final FirebaseUser currentUser = await auth.currentUser();
    //caso user seja != null, salvar usuario dentro do user manager
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
    }
    notifyListeners();
  }
}
