import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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

//carregar dados do usuario
  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    //retorna usuario logado
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    //caso user seja != null, salvar usuario dentro do user manager
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await data.collection("Users").document(currentUser.uid).get();
      user = User.fromDocument(docUser);

      //verificar se usuario é um admin
      final docAdmin = await data.collection('Admin').document(user.id).get();
      if (docAdmin.exists) {
        user.admin = true;
      }

      notifyListeners();
    }
  }

  //habilitar modo admin
  bool get adminEnabled => user != null && user.admin;

  //METODO DE SIGNOUT
  Future<void> signOut() async {
    await auth.signOut();
    user = null;
    notifyListeners();
  }

  //logar com facebook
  Future<void> facebookLogin({Function onFail, Function onSucess}) async {
    loading = true;
    final result = await FacebookLogin().logIn(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        //obter credenciais de login e enviar para firebase
        final credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );

        //logar com credencial
        final authResult = await auth.signInWithCredential(credential);

        //verificar se usuario esta logado
        if (authResult.user != null) {
          final firebaseUser = authResult.user;

          //salvar usuario no database
          user = User(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email,
          );

          await user.saveData();
          onSucess();
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onFail(result.errorMessage);
        break;
    }
    loading = false;
  }
}
