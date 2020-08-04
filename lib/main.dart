import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/screens/base/base_screen.dart';
import 'package:ravelinestores/screens/login/login_screen.dart';
import 'package:ravelinestores/screens/signup/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //padrao lazy é verdadeiro quando chamado
      lazy: false,
      //acessar a classe de usuarios de qualquer lugar do app
      create: (_) => UserManager(),
      child: MaterialApp(
        title: "Raveline's Stores",
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 4, 125, 141),
            accentColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
            appBarTheme: AppBarTheme(elevation: 0.0)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/base',
        //settings recebe as informações da rota
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());

            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
