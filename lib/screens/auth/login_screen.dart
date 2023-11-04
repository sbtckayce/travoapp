import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/variable_const.dart';
import '/config/app_router_name.dart';
import '/localization/app_localization.dart';

import '/cubits/login/login_cubit.dart';

import '/validations/validations.dart';

import '../../utils/show_message_util.dart';
import '../../widgets/widgets.dart';

import '/constants/constants.dart';
import '/utils/app_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ValueNotifier<String> emailValue = ValueNotifier('');
  ValueNotifier<String> passwordValue = ValueNotifier('');

  late ValueNotifier<bool> isRemember = ValueNotifier(false);

  navigateToSignUpScreen() {
    context.pushNamed(AppRouterName.signup);
  }

  navigateToForgotPasswordScreen() {
    context.pushNamed(AppRouterName.forgotPassword);
  }

  late LoginCubit loginCubit;
  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);

    loginCubit.getRememberEmailPassword(
        emailController: emailController,
        passwordController: passwordController,
        context: context);

    loginCubit.getIsRemember(valueRemember: isRemember, context: context);
  }

  clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(VariableConst.emailRemember);
    prefs.remove(VariableConst.passwordRemember);
    prefs.remove(VariableConst.isRemember);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BoxTopAuth(
                isLeading: false,
                imageUrl: 'assets/images/login.png',
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ValueListenableBuilder(
                    valueListenable: emailValue,
                    builder: (context, value, child) {
                      return ValueListenableBuilder(
                        valueListenable: passwordValue,
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: ValueListenableBuilder(
                                          valueListenable: isRemember,
                                          builder: (context, value, child) {
                                            return Checkbox(
                                              value: isRemember.value,
                                              onChanged: (value) {
                                                isRemember.value = value!;
                                                if (isRemember.value == true) {
                                                  loginCubit.setIsRemember(
                                                      value: isRemember.value,
                                                      context: context);

                                                  loginCubit
                                                      .setRememberEmailPassword(
                                                          email: emailController
                                                              .text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                          context: context);
                                                 
                                                          showMessages( 'save_remember'
                                                          .tr(context),ContentType.success, context);
                                                } else {
                                                  clearSharedPreferences();
                                                 
                                                        showMessages( 'remove_remember'
                                                          .tr(context),ContentType.success, context);
                                                }
                                              },
                                              focusColor: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              activeColor: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              checkColor: primaryColor,
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onBackground),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              fillColor:
                                                  MaterialStatePropertyAll(
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onBackground),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'remember_me'.tr(context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      navigateToForgotPasswordScreen();
                                    },
                                    child: Text(
                                      'forgot_password'.tr(context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              StreamBuilder(
                                stream: validations.submitLogin,
                                builder: (context, snapshot) {
                                  return CustomButton(
                                    text: 'login'.tr(context),
                                    backgroundColor: primaryColor,
                                    onPressed: () {
                                      if (snapshot.hasData != true) {
                                          showMessages('complete_form'.tr(context), ContentType.warning, context);
                                      } else {
                                        loginCubit.logIn(emailController.text,
                                            passwordController.text, context);
                                      }
                                    },
                                    size: const Size(double.infinity, 50),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AuthOrtherText(text: 'or_login'.tr(context)),
                              const SizedBox(
                                height: 20,
                              ),
                              const ListSocialButton(),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'no_account'.tr(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      navigateToSignUpScreen();
                                    },
                                    child: Text(
                                      'sign_up'.tr(context),
                                      style: appstyle(
                                          14, primaryColor, FontWeight.w500),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
