import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/common/custom_widgets/empty_card.dart';
import 'package:ravelinestores/managers/admin_orders_manager.dart';
import 'package:ravelinestores/models/order.dart';
import 'package:ravelinestores/screens/orders_screen/components/order_tile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersScreen extends StatelessWidget {
  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 46, 92, 138),
      ),
      drawer: CustomDrawer(),
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
          Consumer<AdminOrdersManager>(
            builder: (contextOut, adminOrdersManager, childOut) {
              final filteredOrders = adminOrdersManager.filteredOrders;

              return SlidingUpPanel(
                controller: panelController,
                body: Column(
                  children: [
                    if (adminOrdersManager.userFiltered != null)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Pedidos de ${adminOrdersManager.userFiltered.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            CustomIconButton(
                              color: Colors.blue,
                              iconData: Icons.close,
                              size: 16,
                              onTap: () {
                                adminOrdersManager.setUserFilter(null);
                              },
                            )
                          ],
                        ),
                      ),
                    if (filteredOrders.isEmpty)
                      Expanded(
                        child: EmptyCard(
                          title:
                              "Nenhum produto encontrado com os filtros selecionados,ou nenhuma venda realizada.\n\nAnuncie seus produtos!",
                          iconData: Icons.border_clear,
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredOrders.length,
                          itemBuilder: (_, index) {
                            return OrderTile(
                              filteredOrders[index],
                              showControls: true,
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 130),
                  ],
                ),

                // painel geral de filtros
                minHeight: 50,
                maxHeight: 300,
                backdropEnabled: true,
                isDraggable: true,

                panel: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.green,
                      onTap: () {
                        if (panelController.isPanelOpen) {
                          panelController.close();
                        } else {
                          panelController.open();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          'Filtros',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    //painel de filtros
                    Expanded(
                      child: Column(
                        children: Status.values.map((status) {
                          return CheckboxListTile(
                            title: Text(
                              Order.getStatusText(status),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            dense: true,
                            value: adminOrdersManager.statusFiltered
                                .contains(status),
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (v) {
                              adminOrdersManager.setStatusFilter(
                                  status: status, enabled: v);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
