import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '/models/contact/contact_model.dart';
import '/models/guest/guest_model.dart';
import '/localization/app_localization.dart';
import '/cubits/user/user_cubit.dart';
import '/widgets/widgets.dart';


class ContactFlightScreen extends StatefulWidget {
  const ContactFlightScreen(
      {super.key,
    });
 
  @override
  State<ContactFlightScreen> createState() => _ContactFlightScreenState();
}

class _ContactFlightScreenState extends State<ContactFlightScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  late String emailText = '';
  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getInfoUser();
  }

  doneContact() {
    context.pop(
      ContactModel(
          email: emailText,
          guestModel: GuestModel(
              name: nameController.text,
              email: emailController.text,
              phone: phoneController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(title: 'contact_details'.tr(context)),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const CircleIndicator();
                    }
                    if (state is UserLoaded) {
                      nameController.text = state.userModel.name;
                      phoneController.text = state.userModel.phoneNumber;
                      emailController.text = state.userModel.email;
                      emailText = state.userModel.email;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValidateName(
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ValidatePhone(
                              controller: phoneController, phoneCode: ''),
                          const SizedBox(
                            height: 10,
                          ),
                          ValidateEmail(controller: emailController),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'E-ticket will be sent to your E-mail',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            text: 'done'.tr(context),
                            size: const Size(double.infinity, 50),
                            onPressed: doneContact,
                          )
                        ],
                      );
                    } else {
                      return const TextError();
                    }
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
