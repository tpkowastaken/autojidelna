import 'package:autojidelna/classes_enums/all.dart';
import 'package:autojidelna/methods_vars/ordering.dart';
import 'package:autojidelna/providers.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDishButton extends StatelessWidget {
  const OrderDishButton(this.dish, {super.key});
  final Jidlo dish;

  @override
  Widget build(BuildContext context) {
    bool ordering = context.select<DishesOfTheDay, bool>((data) => data.ordering);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    StavJidla stavJidla = getStavJidla(dish);
    bool isPrimary = getPrimaryState(stavJidla);
    bool disabled = !ordering ? isButtonEnabled(stavJidla) : true;

    return Selector<DishesOfTheDay, Jidelnicek>(
      selector: (_, p1) => p1.menu,
      builder: (context, menu, child) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary ? colorScheme.primary : colorScheme.secondary,
              foregroundColor: isPrimary ? colorScheme.onPrimary : colorScheme.onSecondary,
            ),
            onPressed: ordering || disabled ? null : () => pressed(context, dish, stavJidla),
            child: Text(getObedText(context, dish, stavJidla)),
          ),
        );
      },
    );
  }
}