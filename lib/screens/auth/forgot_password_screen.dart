import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../utils/show_message_util.dart';
import '/localization/app_localization.dart';
import '/cubits/forgot_password/forgot_password_cubit.dart';

import '/validations/validations.dart';
import '/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late ForgotPasswordCubit forgotPasswordCubit;
  @override
  void initState() {
    super.initState();
    forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BoxTopAuth(imageUrl: 'assets/images/forgotPassword.png'),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValidateEmail(
                      controller: emailController,
                      onChanged: (value) {
                        validations.sinkEmail.add(value);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'send'.tr(context),
                      size: const Size(
                        double.infinity,
                        50,
                      ),
                      onPressed: () {
                      if(emailController.text.isNotEmpty){
                          forgotPasswordCubit.forgotPassword(
                            emailController.text, context);
                      }else{
                             showMessages('complete_form'.tr(context), ContentType.warning, context);
                      }
                      },
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
