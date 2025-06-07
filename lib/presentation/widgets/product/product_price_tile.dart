import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/widgets/buttons/remove_product_button.dart';
import 'package:flutter/material.dart';

class ProductPriceTile extends StatelessWidget {
  final Pizza product;
  final bool selected;
  final int index;
  const ProductPriceTile(this.product, this.index, this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Tooltip(
          message: product.readableIngredients(),
          child: ListTile(
            trailing: RemoveProductButton(index),
            shape: RoundedRectangleBorder(
              side: BorderSide(),
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(product.name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${product.price} €', textAlign: TextAlign.end),
                SizedBox(width: 20),
              ],
            ),
            selected: selected,
            tileColor: colors.primaryContainer,
            textColor: colors.onPrimaryContainer,
            selectedTileColor: colors.primary,
            selectedColor: colors.onPrimary,
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
