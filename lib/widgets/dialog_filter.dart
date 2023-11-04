import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';
import '/constants/constants.dart';

class DialogFilter extends StatelessWidget {
  const DialogFilter(
      {super.key, required this.typeRangeSilder, this.onPressed});
  final Widget typeRangeSilder;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Dialog(

    backgroundColor: nostaglaPerfume,
      child: Container(
        width: double.infinity,
        height: 300,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Spacer(),
            typeRangeSilder,
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        minimumSize: const Size(120, 50)),
                    onPressed: onPressed,
                    child: Text(
                      'filter'.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minimumSize: const Size(120, 50)),
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      'cancel'.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
