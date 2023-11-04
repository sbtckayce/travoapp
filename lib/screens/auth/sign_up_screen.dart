import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '/localization/app_localization.dart';
import '/constants/constants.dart';
import '/cubits/signup/signup_cubit.dart';

import '../../utils/show_message_util.dart';
import '/validations/validations.dart';

import '../../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final countryNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ValueNotifier<String> phoneCode = ValueNotifier('');
  late SignUpCubit signUpCubit;
  @override
  void initState() {
    super.initState();
    signUpCubit = BlocProvider.of<SignUpCubit>(context);
  }

  chooseCountry() {
    showCountryPicker(
      countryListTheme: CountryListThemeData(
          searchTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.secondary),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          textStyle: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      context: context,
      showPhoneCode: true,
      onSelect: (country) {
        countryNameController.text = country.name;

        phoneCode.value = '+ ${country.phoneCode}';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BoxTopAuth(imageUrl: 'assets/images/signUp.png'),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  ValidateName(
                      onChanged: (value) {
                        validations.sinkName.add(value);
                      },
                      controller: nameController),
                  ValueListenableBuilder(
                    valueListenable: phoneCode,
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValidateCountry(
                            controller: countryNameController,
                            onTap: chooseCountry,
                          ),
                          ValidatePhone(
                            phoneCode: phoneCode.value,
                            onChanged: (value) {
                              validations.sinkPhone.add(value);
                            },
                            controller: phoneController,
                          ),
                        ],
                      );
                    },
                  ),
                  ValidateEmail(
                    controller: emailController,
                    onChanged: (value) {
                      validations.sinkEmail.add(value);
                    },
                  ),
                  ValidatePassword(
                    controller: passwordController,
                    onChanged: (value) {
                      validations.sinkPassword.add(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TermAndCondition(),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: validations.submitLogin,
                    builder: (context, snapshot) {
                      return CustomButton(
                        text: 'sign_up'.tr(context),
                        size: const Size(double.infinity, 50),
                        backgroundColor: primaryColor,
                        onPressed: () {
                          if (snapshot.hasData != true) {
                            showMessages('complete_form'.tr(context),
                                ContentType.warning, context);
                          } else {
                            signUpCubit.signup(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                country: countryNameController.text,
                                phone: phoneCode.value + phoneController.text);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthOrtherText(text: 'or_sign_up'.tr(context)),
                  const SizedBox(
                    height: 20,
                  ),
                  const ListSocialButton(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
