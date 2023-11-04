import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user/user_cubit.dart';

class NameDescInfoCheckOutFlightItem extends StatefulWidget {
  const NameDescInfoCheckOutFlightItem(
      {super.key, required this.name, required this.desc});
  final String name;
  final String desc;

  @override
  State<NameDescInfoCheckOutFlightItem> createState() => _NameDescInfoCheckOutFlightItemState();
}

class _NameDescInfoCheckOutFlightItemState extends State<NameDescInfoCheckOutFlightItem> {
   late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
  
    userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getInfoUser();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.desc,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary),
        )
      ],
    );
  }
}
