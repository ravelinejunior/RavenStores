import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/models/item_size.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:ravelinestores/screens/home/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final Product product;
  const SizesForm({this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormField<List<ItemSize>>(
          initialValue: List.from(product.sizesList),
          validator: (sizes) {
            //validator recebe a lista de tamanhos
            if (sizes.isEmpty)
              return 'Insira ao menos, um tipo';
            else
              return null;
          },
          autovalidate: true,
          builder: (state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        "Tipos",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),

                    //botao de adição de tamanhos
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Theme.of(context).primaryColor,
                      onTap: () {
                        //passar um novo tamanho dentro da lista
                        state.value.add(ItemSize());
                        state.didChange(state.value);
                      },
                    ),
                  ],
                ),

                //lista de tamanhos widget
                Column(
                  // mapear a lista de tamanhos
                  // local onde os widgets de tamanho serao criados
                  children: state.value.map<Widget>((size) {
                    return EditItemSize(
                      //chave do size para cada objeto size
                      key: ObjectKey(size),
                      itemSize: size,
                      onRemove: () {
                        //recuperar lista de tamanhos e remover item selecionado
                        state.value.remove(size);
                        state.didChange(state.value);
                      },
                      //mover objeto para cima
                      onMoveUp: size != state.value.first
                          ? () {
                              //recuperar o indice do item clicado
                              final index = state.value.indexOf(size);
                              //remover tamanho
                              state.value.remove(size);
                              //inserir tamanho em outro ponto da lista
                              state.value.insert(index - 1, size);
                              state.didChange(state.value);
                            }
                          : null,

                      //mover objeto para baixo
                      onMoveDown: size != state.value.last
                          ? () {
                              //recuperar o indice do item clicado
                              final index = state.value.indexOf(size);
                              //remover tamanho
                              state.value.remove(size);
                              //inserir tamanho em outro ponto da lista
                              state.value.insert(index + 1, size);
                              state.didChange(state.value);
                            }
                          : null,
                    );
                  }).toList(),
                ),
                //validação dos erros
                if (state.hasError)
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 16, left: 16),
                    child: Text(
                      state.errorText,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
