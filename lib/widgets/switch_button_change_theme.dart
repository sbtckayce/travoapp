import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/change_theme/change_theme_cubit.dart';

class SwitchButtonChangeTheme extends StatelessWidget {
  const SwitchButtonChangeTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
          BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, state) {
          return Transform.scale(
            scale: 0.8,
            child: Switch.adaptive(
              value: state.value,
              onChanged: (value) {
                value
                    ? context
                        .read<ChangeThemeCubit>()
                        .onDarkMode()
                    : context
                        .read<ChangeThemeCubit>()
                        .onLightMode();
              },
            ),
          );
        },
      
    );
  }
}
