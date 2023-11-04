import 'package:flutter/material.dart';
import '/models/contact/contact_model.dart';

class ContactBoxInherit extends InheritedWidget {
  const ContactBoxInherit(this.resultContact, {super.key, required super.child});

  final ContactModel? resultContact;
 
 
  
  static ContactBoxInherit of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContactBoxInherit>()!;
  }
 
  @override
  bool updateShouldNotify(ContactBoxInherit oldWidget) {
    return true;
  }
}