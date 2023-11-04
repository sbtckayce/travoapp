import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../utils/show_message_util.dart';
import '/models/card/card_model.dart';
import '/localization/app_localization.dart';
import '/widgets/widgets.dart';

import '../../models/room/room_model.dart';

class AddCardHotelScreen extends StatefulWidget {
  const AddCardHotelScreen(
      {super.key,
      required this.hotelId,
      required this.roomId,
      required this.roomModel});
  final String hotelId;
  final String roomId;
  final RoomModel roomModel;
  @override
  State<AddCardHotelScreen> createState() => _AddCardHotelScreenState();
}

class _AddCardHotelScreenState extends State<AddCardHotelScreen> {
  final nameController = TextEditingController();
  final cardController = TextEditingController();
  final dateController = TextEditingController();
  final cvvController = TextEditingController();
  final countryNameController = TextEditingController();
  chooseCountry() {
    showCountryPicker(
      countryListTheme: CountryListThemeData(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          searchTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
          textStyle: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      context: context,
      showPhoneCode: true,
      onSelect: (country) {
        countryNameController.text = country.name;
      },
    );
  }

  addCard() {
    if (nameController.text.isEmpty ||
        cardController.text.isEmpty ||
        dateController.text.isEmpty ||
        cvvController.text.isEmpty ||
        countryNameController.text.isEmpty) {
         showMessages('complete_form'.tr(context), ContentType.warning, context);
    } else {
      context.pop(CardModel(
          name: nameController.text,
          cardNumber: cardController.text,
          expDate: dateController.text,
          cvv: cvvController.text,
          country: countryNameController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(title: 'add_card'.tr(context)),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValidateName(controller: nameController),
                  const SizedBox(
                    height: 10,
                  ),
                  ValidateCardNumber(controller: cardController),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ValidateExpDate(controller: dateController),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ValidateCvv(controller: cvvController),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValidateCountry(
                    controller: countryNameController,
                    onTap: chooseCountry,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'add_card'.tr(context),
                    onPressed: addCard,
                    size: const Size(double.infinity, 50),
                  )
                  
                ],
              ),
            )))
          ],
        ),
      ),
    );
  }
}
