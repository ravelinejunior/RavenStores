import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/helpers/firebase_errors.dart';
import 'package:ravelinestores/models/user.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
//tratar exceções

  bool loading = false;

  //metodo para autenticar usuarios
  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    setLoading(true);
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await Future.delayed(Duration(seconds: 4));

      //apos receber o resultado da operação, verificar os resultados

      onSucess();
    } on PlatformException catch (e) {
      print(getErrorString(e.code));
      onFail(getErrorString(e.code));
    }

    setLoading(false);
  }

  //metodo para verificar se ha algo carregando
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
