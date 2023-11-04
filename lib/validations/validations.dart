import 'dart:async';

import 'package:rxdart/rxdart.dart';

final validations = Validations();

class Validations {
  final _email = BehaviorSubject.seeded('@');

  final _password = BehaviorSubject.seeded('');

  final _name = BehaviorSubject.seeded('');

  final _phone = BehaviorSubject.seeded('0');

  final _cardNumber = BehaviorSubject.seeded('');

  final _expDate = BehaviorSubject.seeded('');

  final _cvv = BehaviorSubject.seeded('');

  Stream<String> get email => _email.stream.transform(validateEmail);
  Sink<String> get sinkEmail => _email.sink;

  Stream<String> get password => _password.stream.transform(validatePassword);
  Sink<String> get sinkPassword => _password.sink;

  Stream<String> get name => _name.stream.transform(validateName);
  Sink<String> get sinkName => _name.sink;

  Stream<String> get phone => _phone.stream.transform(validatePhone);
  Sink<String> get sinkPhone => _phone.sink;

  Stream<String> get cardNumber =>
      _cardNumber.stream.transform(validateCardNumber);
  Sink<String> get sinkCardNumber => _cardNumber.sink;

  Stream<String> get expDate => _expDate.stream.transform(validateExpDate);
  Sink<String> get sinkExpDate => _expDate.sink;

  Stream<String> get cvv => _cvv.stream.transform(validateCvv);
  Sink<String> get sinkCvv => _cvv.sink;

  Stream<bool> get submitLogin =>
      Rx.combineLatest2(email, password, (a, b) => true);

  Stream<bool> get submitSignUp =>
      Rx.combineLatest4(name, phone, email, password, (a, b, c, d) => true);


  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length != 1) {
        isEmail(data)
            ? sink.add(data)
            : sink.addError('Please enter valid email');
      }
    },
  );
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        isName(data)
            ? sink.add(data)
            : sink.addError('Please enter valid name');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        data.length > 8
            ? sink.add(data)
            : sink.addError('Password must be at least 8 characters');
      }
    },
  );
  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length != 1) {
        isPhone(data)
            ? sink.add(data)
            : sink.addError('Please enter valid phone number');
      }
    },
  );
  final validateCardNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        isCardNumber(data)
            ? sink.add(data)
            : sink.addError('Please enter valid visa card');
      }
    },
  );
  final validateExpDate = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        isExpDate(data)
            ? sink.add(data)
            : sink.addError('Pls enter valid expDate');
      }
    },
  );
  final validateCvv = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isNotEmpty) {
        isCvv(data) ? sink.add(data) : sink.addError('Please enter valid cvv');
      }
    },
  );
  static bool isEmail(String email) {
    String value =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(value);
    return regExp.hasMatch(email);
  }

  static bool isName(String name) {
    String value = r'^[a-zA-Z ]+$';

    RegExp regExp = RegExp(value);
    return regExp.hasMatch(name);
  }

  static bool isPhone(String phone) {
    String value = r'^(?:[1-9])?[0-9]{9,12}$';
    RegExp regExp = RegExp(value);
    return regExp.hasMatch(phone);
  }

  static bool isCardNumber(String cardNumber) {
    String value = r'^4[0-9]{12}(?:[0-9]{3})?$';
    RegExp regExp = RegExp(value);
    return regExp.hasMatch(cardNumber);
  }

  static bool isExpDate(String expDate) {
    String value = r'^(0[1-9]|1[0-2])\/([0-9]{2})$';
    RegExp regExp = RegExp(value);
    return regExp.hasMatch(expDate);
  }

  static bool isCvv(String cvv) {
    String value = r'^[0-9]{3,4}$';
    RegExp regExp = RegExp(value);
    return regExp.hasMatch(cvv);
  }
}
