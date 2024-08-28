import 'package:autojidelna/classes_enums/all.dart';
import 'package:autojidelna/methods_vars/capitalize.dart';
import 'package:autojidelna/methods_vars/get_correct_date_string.dart';
import 'package:autojidelna/providers.dart';
import 'package:autojidelna/shared_widgets/canteen/food_section_list_tile.dart';
import 'package:autojidelna/shared_widgets/settings/custom_divider.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DayCard extends StatelessWidget {
  const DayCard({super.key, required this.jidelnicek});
  final Jidelnicek jidelnicek;

  @override
  Widget build(BuildContext context) {
    if (jidelnicek.jidla.isEmpty) return const SizedBox();
    return Card.outlined(
      elevation: 0.6,
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Theme.of(context).dividerTheme.color!)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          DayCardheader(date: jidelnicek.den),
          const CustomDivider(isTransparent: false),
          FoodSectionListTile(title: 'OBĚD', selection: jidelnicek.jidla),
        ],
      ),
    );
  }
}

class DayCardheader extends StatelessWidget {
  const DayCardheader({required this.date, super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Selector<AppearancePreferences, DateFormatOptions>(
            selector: (p0, p1) => p1.dateFormat,
            builder: (context, format, ___) {
              String day = capitalize(DateFormat('EEEE', Localizations.localeOf(context).toLanguageTag()).format(date));
              return Text(
                '$day - ${getCorrectDateString(format, date: date)}',
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          ),
        ),
      ],
    );
  }
}
