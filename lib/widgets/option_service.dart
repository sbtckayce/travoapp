import 'package:flutter/material.dart';

class OptionService extends StatelessWidget {
  const OptionService(
      {super.key, required this.imageUrl, required this.name});
  final String imageUrl;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageUrl,
                width: 32,
                height: 32,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    
                    fontWeight: FontWeight.w400),
              )
            ],
          
        ),
      ),
    );
  }
}
