import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../cubits/promo/promo_cubit.dart';
import '/repositories/promo/promo_repository.dart';

import '../../models/promo/promo_model.dart';
import '/localization/app_localization.dart';
import '/constants/constants.dart';

import '../../utils/show_message_util.dart';

import '../../widgets/widgets.dart';

class PromoFlightScreen extends StatefulWidget {
  const PromoFlightScreen({
    super.key,
  });

  @override
  State<PromoFlightScreen> createState() => _PromoFlightScreenState();
}

class _PromoFlightScreenState extends State<PromoFlightScreen> {
  final promoController = TextEditingController();
  ValueNotifier<bool> isCheckCode = ValueNotifier(false);
  getCode() {
    if (promoController.text.isNotEmpty) {
      isCheckCode.value = true;
      promoCubit.getPromo(promoController.text);
    }
  }

  PromoModel? resultPromo;
  donePromo() {
    if (promoController.text.isNotEmpty) {
      context.pop(resultPromo);
    }
  }

  late PromoCubit promoCubit;
  late PromoRepository promoRepository;
  @override
  void initState() {
    super.initState();
    promoRepository = PromoRepository();
    promoCubit = PromoCubit(promoRepository);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(title: 'promo'.tr(context)),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onBackground,
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: promoController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                hintText: 'coupon_code'.tr(context),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: purpleShade,
                                  minimumSize: const Size(100, 50)),
                              onPressed: getCode,
                              child: Text('add_code'.tr(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isCheckCode,
                      builder: (context, value, child) {
                        return isCheckCode.value
                            ? BlocBuilder<PromoCubit, PromoState>(
                                bloc: promoCubit,
                                builder: (context, state) {
                                  if (state is PromoLoading) {
                                    return const CircleIndicator();
                                  }
                                  if (state is PromoLoaded) {
                                    resultPromo = state.promoModel;
                                    return state.promoModel.code.isNotEmpty
                                        ? ItemPromoCode(
                                            promoModel: state.promoModel)
                                        : NoItem(
                                            text: 'un_available'.tr(context));
                                  } else {
                                    return const TextError();
                                  }
                                })
                            : const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isCheckCode,
                      builder: (context, value, child) {
                        return CustomButton(
                          text: 'done'.tr(context),
                          backgroundColor: primaryColor,
                          onPressed: () {
                            if (promoController.text.isNotEmpty) {
                              isCheckCode.value = false;
                              donePromo();
                            } else {
                              showMessages('pls_enter_code'.tr(context),
                                  ContentType.warning, context);
                            }
                          },
                          size: const Size(double.infinity, 50),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
