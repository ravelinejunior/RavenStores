import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize itemSize;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  const EditItemSize(
      {Key key, this.itemSize, this.onRemove, this.onMoveUp, this.onMoveDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          //nome tamanho
          Expanded(
            flex: 30,
            child: TextFormField(
              initialValue: itemSize.name,
              decoration: InputDecoration(
                labelText: 'Título',
                isDense: true,
              ),
              validator: (name) {
                if (name.isEmpty)
                  return 'Inválido';
                else
                  return null;
              },
              autovalidate: false,
              //armazenar alterações no item
              onChanged: (name) => itemSize.name = name,
            ),
          ),

          const SizedBox(width: 4),

          //tamanho estoque
          Expanded(
            flex: 30,
            child: TextFormField(
              initialValue: itemSize.stock?.toString(),
              decoration: InputDecoration(
                labelText: 'Estoque',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              validator: (stock) {
                if (int.tryParse(stock) == null)
                  return 'Inválido';
                else
                  return null;
              },
              autovalidate: false,
              //armazenar alterações no item
              onChanged: (stock) => itemSize.stock = int.tryParse(stock),
            ),
          ),

          const SizedBox(width: 4),

          //preço tamanho
          Expanded(
            flex: 40,
            child: TextFormField(
              initialValue: itemSize.price?.toStringAsFixed(2),
              decoration: InputDecoration(
                labelText: 'Preço',
                isDense: true,
                prefixText: 'R\$ ',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (price) {
                if (num.tryParse(price) == null)
                  return 'Inválido';
                else
                  return null;
              },
              autovalidate: false,
              //armazenar alterações no item
              onChanged: (price) => itemSize.price = num.tryParse(price),
            ),
          ),

          //widgets de remoção e de movientação de tipos
          //botao remover widget
          CustomIconButton(
            iconData: Icons.remove,
            color: Colors.red,
            onTap: onRemove,
          ),

          //botao arrastar cima widget
          CustomIconButton(
            iconData: Icons.arrow_drop_up,
            color: color,
            onTap: onMoveUp,
          ),

          //botao arrastar baixo widget

          CustomIconButton(
            iconData: Icons.arrow_drop_down,
            color: color,
            onTap: onMoveDown,
          ),
        ],
      ),
    );
  }
}
