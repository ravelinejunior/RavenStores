import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/managers/page_manager.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/screens/admin_orders/admin_orders_screen.dart';
import 'package:ravelinestores/screens/admin_users/admin_users_screen.dart';
import 'package:ravelinestores/screens/home/home_screen.dart';
import 'package:ravelinestores/screens/orders_screen/orders_screen.dart';
import 'package:ravelinestores/screens/products/products_screen.dart';
import 'package:ravelinestores/screens/stores/stores_screen.dart';

class BaseScreen extends StatefulWidget {
  //page view que irá controlar o page view
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      //será utilizado para verificar o estado da pagina atual
      create: (_) => PageManager(pageController),
      child: SafeArea(
        top: true,
        child: Consumer<UserManager>(
          builder: (context, userManager, child) {
            return PageView(
              controller: pageController,
              //colocar as telas dentro do children
              children: <Widget>[
                //home
                HomeScreen(),
                //Produtos Screen
                ProductsScreen(),

                //meus pedidos
                OrdersScreen(),

                //lojas
                StoreScreen(),

                Scaffold(
                  appBar: AppBar(
                    title: const Text("Categorias"),
                    elevation: 5,
                    shadowColor: Colors.orange,
                    backgroundColor: Colors.blueAccent,
                    centerTitle: true,
                  ), //DRAWER WIDGET
                  drawer: CustomDrawer(),
                ),

                //admin part
                if (userManager.adminEnabled) ...[
                  AdminUsersScreen(),
                  AdminOrdersScreen(),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
