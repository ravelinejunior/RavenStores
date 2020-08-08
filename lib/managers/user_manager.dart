import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/helpers/firebase_errors.dart';
import 'package:ravelinestores/models/user.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  final Firestore data = Firestore.instance;
//tratar exceções

//pegar usuario logado
  UserManager() {
    _loadCurrentUser();
  }

  //recuperar senha
  void recoverPass(String email) {
    auth.sendPasswordResetEmail(email: email);
  }

  bool _loading = false;
  bool get loading => _loading;
  //set
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //verificador se usuario logado
  bool get isLoggedIn => user != null;

  //metodo para autenticar usuarios
  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await Future.delayed(Duration(seconds: 4));

      //apos receber o resultado da operação, verificar os resultados
      await _loadCurrentUser(firebaseUser: result.user);

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
      this.user = user;

      //aguardar dados serem salvos
      await user.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    //retorna usuario logado
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    //caso user seja != null, salvar usuario dentro do user manager
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await data.collection("Users").document(currentUser.uid).get();
      user = User.fromDocument(docUser);
      print(user.name);
      notifyListeners();
    }
  }

  //METODO DE SIGNOUT
  Future<void> signOut() async {
    await auth.signOut();
    user = null;
    notifyListeners();
  }
}
