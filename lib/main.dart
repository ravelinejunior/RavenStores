import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/admin_users_manager.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/managers/home_manager.dart';
import 'package:ravelinestores/managers/product_manager.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:ravelinestores/screens/address/address_screen.dart';
import 'package:ravelinestores/screens/base/base_screen.dart';
import 'package:ravelinestores/screens/cart/cart_screen.dart';
import 'package:ravelinestores/screens/edit_product/edit_product_screen.dart';
import 'package:ravelinestores/screens/login/login_screen.dart';
import 'package:ravelinestores/screens/product_screen/product_screen.dart';
import 'package:ravelinestores/screens/products/products_screen.dart';
import 'package:ravelinestores/screens/selected_product/selected_product.dart';
import 'package:ravelinestores/screens/signup/signup_screen.dart';
import 'package:ravelinestores/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //lista de providers
        ChangeNotifierProvider(
          create: (cnProvider) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (productProvider) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider<HomeManager>(
          create: (contextHome) => HomeManager(),
          lazy: false,
        ),
        //toda vez que houver alteração no userManager ou cartmanager ele notificará a classe
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (context) => CartManager(),
          lazy: false,
          //injetar cartManager no userManager
          // o .. é para retornar um cartmanager
          update: (context, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),

        //vincular o userManager com o AdminManager
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (context, userManager, adminUsersManager) =>
              adminUsersManager..updateUsersManager(userManager),
        ),
      ],
      child: MaterialApp(
        title: "Raveline's Stores",
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 4, 125, 141),
            accentColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
            appBarTheme: AppBarTheme(elevation: 0.0)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        //settings recebe as informações da rota
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());

            case '/products':
              return MaterialPageRoute(builder: (_) => ProductsScreen());

            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(settings.arguments as Product),
              );

            case '/selectedProduct':
              return MaterialPageRoute(
                builder: (_) => SelectedProduct(),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => CartScreen(),
              );

            case '/address':
              return MaterialPageRoute(
                builder: (_) => AddressScreen(),
              );

            case '/editProduct':
              return MaterialPageRoute(
                builder: (_) =>
                    EditProductScreen(settings.arguments as Product),
              );

            case '/splash':
              return MaterialPageRoute(builder: (context) => SplashScreen());

            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
