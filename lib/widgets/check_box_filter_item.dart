import 'package:flutter/material.dart';
import '/models/check_box/check_box_model.dart';

import '../constants/constants.dart';

class CheckBoxFilterItem extends StatelessWidget {
  const CheckBoxFilterItem({super.key, required this.checkBoxModel, this.onChanged,});
  final CheckBoxModel checkBoxModel;
  final Function(bool?)? onChanged;
  
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        children: [
          Image.asset(
            checkBoxModel.imageUrl,
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            checkBoxModel.name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: primaryColor),
          )
        ],
      ),
      value: checkBoxModel.value,
      onChanged: onChanged,
    );
  }
}