import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';

import '../cubits/place/place_cubit.dart';
import '../repositories/place/place_repository.dart';
import 'widgets.dart';

class DialogFromToBookFlight extends StatefulWidget {
  const DialogFromToBookFlight({
    super.key,
    required this.text,
  });
  final ValueNotifier text;
  @override
  State<DialogFromToBookFlight> createState() => _DialogFromToBookFlightState();
}

class _DialogFromToBookFlightState extends State<DialogFromToBookFlight> {
  late PlaceCubit placeCubit;
  late PlaceRepository placeRepository;
  @override
  void initState() {
    super.initState();
    placeRepository = PlaceRepository();
    placeCubit = PlaceCubit(placeRepository);

    placeCubit.getAllPlace();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<PlaceCubit, PlaceState>(
        bloc: placeCubit,
        builder: (context, state) {
          if (state is PlaceLoading) {
            return const CircleIndicator();
          }
          if (state is PlaceLoaded) {
            return Container(
              width: double.infinity,
              height: 500,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'name'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'rating'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.places.length,
                      itemBuilder: (context, index) {
                        return PlaceItemBookFlight(
                            onPressed: () {
                              widget.text.value = state.places[index].name;
                              context.pop();
                            },
                            placeModel: state.places[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const TextError();
          }
        },
      ),
    );
  }
}
