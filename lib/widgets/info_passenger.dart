import 'package:flutter/material.dart';

import 'passenger_box_inherit.dart';


class InfoPassenger extends StatelessWidget {
  const InfoPassenger({super.key});

  @override
  Widget build(BuildContext context) {
    final resultPassenger = PassengerBoxInherit.of(context).resultPassenger;
    return resultPassenger !=null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Name : ${resultPassenger.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                'Email : ${resultPassenger.email}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                'Country : ${resultPassenger.country}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                'Phone : ${resultPassenger.phone}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          )
        : SizedBox(
            child: Text(resultPassenger.toString()),
          );
  }
}
