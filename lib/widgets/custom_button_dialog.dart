import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/constants/constants.dart';
import '/localization/app_localization.dart';

import '../utils/app_style.dart';

class CustomButtonDialog extends StatelessWidget {
  const CustomButtonDialog({super.key, this.onSubmit});
  final Function()? onSubmit;
  @override
  Widget build(BuildContext context) {
    return  Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration:  BoxDecoration(
                      border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    left: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                  )),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Text(
                        'cancel'.tr(context),
                        style: appstyle(15, primaryColor, FontWeight.w400),
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: Container(
                height: 40,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary.withOpacity(0.2))),
                  child: Center(
                    child: GestureDetector(
                      onTap: onSubmit,
                      child: Text(
                        'submit'.tr(context),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  )),
            )
          ],
        );
  }
}