import 'package:flutter/material.dart';

class ConfirmInfoPaymentBank extends StatelessWidget {
  const ConfirmInfoPaymentBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Image.asset(
                'assets/images/bank.png',
                width: 32,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Bank Transfer',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
        );
  }
}