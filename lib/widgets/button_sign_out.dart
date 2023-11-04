import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/repositories/place/place_repository.dart';
import '/utils/variable_const.dart';


import '/widgets/widgets.dart';
import '/utils/box_hive.dart';

import '../cubits/signout/signout_cubit.dart';
import '../models/place/place_model.dart';

class ButtonSignOut extends StatefulWidget {
  const ButtonSignOut({
    super.key,
  });

  @override
  State<ButtonSignOut> createState() => _ButtonSignOutState();
}

class _ButtonSignOutState extends State<ButtonSignOut> {
  late Box<PlaceModel> boxPlace;
  late SignOutCubit signOutCubit;

  late PlaceRepository placeRepository;

  @override
  void initState() {
    super.initState();
    boxPlace = BoxHive.boxPlaces();
    signOutCubit = BlocProvider.of<SignOutCubit>(context);

    placeRepository = PlaceRepository();
  }

  clearSharePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    placeRepository.getAllPlace().listen((event) {
      for (var e in event) {
        prefs.remove('${VariableConst.placeFavourite}${e.name}');
      }
    });

    boxPlace.clear();
  }

  showRateAppAndLogout() async {
    await showDialog(
      context: context,
      builder: (context) {
        return DialogRateApp(
          onSubmit: () {
            signOutCubit.signOut(context);
            clearSharePreference();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showRateAppAndLogout();
      },
      child: Icon(
        Icons.logout_outlined,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
