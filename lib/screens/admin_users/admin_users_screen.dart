import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/managers/admin_users_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: Consumer<AdminUsersManager>(
        builder: (context, adminUsersManager, child) {
          return AlphabetListScrollView(
            showPreview: true,
            highlightTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
            strList: adminUsersManager.names, //lista de nomes
            indexedHeight: (index) => 80,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email,
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.w700),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
