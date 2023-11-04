import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TypeRangeSlider extends StatelessWidget {
  const TypeRangeSlider({
    super.key,
    required this.name,
    required this.rangeValues,
    this.isDouble = false,
    required this.min,
    required this.max,
    this.unitInt = '',
    this.unitDouble = '',
  });
  final String name;
  final bool? isDouble;
  final ValueNotifier<RangeValues> rangeValues;
  final double min;
  final double max;
  final String? unitInt;
  final String? unitDouble;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(
          height: 40,
        ),
        ValueListenableBuilder(
          valueListenable: rangeValues,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isDouble!
                          ? '${rangeValues.value.start.toDouble().toStringAsFixed(1)} $unitDouble '
                          : '${rangeValues.value.start.toInt()} $unitInt',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(   fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Text(
                      isDouble!
                          ? '${rangeValues.value.end.toDouble().toStringAsFixed(1)} $unitDouble'
                          : '${rangeValues.value.end.toInt()} $unitInt',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                RangeSlider(
                  values: rangeValues.value,
                  activeColor: primaryColor,
                  labels: null,
                  inactiveColor: Theme.of(context).colorScheme.secondary,
                  min: min,
                  max: max,
                  onChanged: (value) {
                    rangeValues.value = value;
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
