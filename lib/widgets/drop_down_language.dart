
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubits/change_language/change_language_cubit.dart';

import '../constants/constants.dart';

class DropDownLanguage extends StatefulWidget {
  const DropDownLanguage({super.key});

  @override
  State<DropDownLanguage> createState() => _DropDownLanguageState();
}

class _DropDownLanguageState extends State<DropDownLanguage> {
  ValueNotifier<String> language = ValueNotifier('en');
  late ChangeLanguageCubit changeLanguageCubit;
  @override
  void initState() {
    super.initState();
    changeLanguageCubit = BlocProvider.of<ChangeLanguageCubit>(context);

  }

  changeLanguge(String value) {
    changeLanguageCubit.setLanguage(value);
    language.value = value;

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: language,
      builder: (context, value, child) {
        return Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1, color: Theme.of(context).colorScheme.secondary)),
          child: DropdownButton(
            alignment: Alignment.topLeft,
            value: language.value,
            dropdownColor: primaryColor,
            borderRadius: BorderRadius.circular(5),
            underline: const SizedBox(),
            isExpanded: true,
            items: [
              DropdownMenuItem(
                value: 'vi',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/vi.png',
                      width: 35,
                    ),
                    Text(
                      'Vietnamese',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'en',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/en.png',
                      width: 35,
                    ),
                    Text(
                      'English',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              )
            ],
            onChanged: (value) {
              changeLanguge(value!);
            },
          ),
        );
      },
    );
  }
}
