import 'dart:convert' as convert;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contacts/models/contacts.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Network {
  static List<Contact> contacts = [];
  static Uri url = Uri.parse('https://retoolapi.dev/Djr548/Contacts');
  static Uri urlWithId(String id) {
    return Uri.parse('https://retoolapi.dev/Djr548/Contacts/' + id);
  }

  static Future<void> getData() async {
    contacts.clear();
    http.get(Network.url).then((response) {
      if (response.statusCode == 200) {
        List jsonDecode = convert.jsonDecode(response.body);
        jsonDecode.forEach((element) {
          contacts.add(Contact.fromJson(element));
        });
      }
    });
  }

  static void postData(
      {required String phone, required String fullName}) async {
    Contact contact = Contact(phone: phone, fullName: fullName);
    http.post(Network.url, body: contact.toJson()).then((response) {
      if (response.statusCode == 200) {}
    });
  }

  static void putData(
      {required String phone,
      required String fullName,
      required int id}) async {
    Contact contact = Contact(phone: phone, fullName: fullName);
    http
        .put(Network.urlWithId(id.toString()), body: contact.toJson())
        .then((response) {
      if (response.statusCode == 200) {}
    });
  }

  static void deleteData({required int? id}) async {
    http.delete(Network.urlWithId(id.toString())).then((response) {
      if (response.statusCode == 200) {}
    });
  }

  //! Check Internet
  static bool isConnected = false;
  static Future<bool> checkInternet(BuildContext context) async {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.wifi ||
          status == ConnectivityResult.mobile) {
        isConnected = true;
      } else {
        showInternetError(context);
        isConnected = false;
      }
      print(Network.isConnected);
    });
    return isConnected;
  }

  //! Show Internet Error
  static void showInternetError(BuildContext context) {
    CoolAlert.show(
      width: 100,
      context: context,
      type: CoolAlertType.error,
      title: 'خطا',
      text: '! شما به اینترنت متصل نیستید',
      confirmBtnText: 'باشه',
      confirmBtnTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      confirmBtnColor: Colors.redAccent,
    );
  }
}
