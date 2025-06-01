import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:flutter/material.dart';

class ProductPriceTile extends StatelessWidget {
  final Pizza product;
  final bool selected;
  const ProductPriceTile(this.product, this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Tooltip(
          message: product.readableIngredients(),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(),
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(product.name),
            subtitle: Text('${product.price} €', textAlign: TextAlign.end),
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
