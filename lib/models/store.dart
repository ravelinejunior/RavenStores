import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/address.dart';
import 'package:ravelinestores/helpers/extensions.dart';

class Store {
  Store.fromDocument(DocumentSnapshot documentSnapshot) {
    name = documentSnapshot.data['name'] as String;
    phone = documentSnapshot.data['phone'] as String;
    image = documentSnapshot.data['image'] as String;
    address = Address.fromMap(
        documentSnapshot.data['address'] as Map<String, dynamic>);
    opening = (documentSnapshot.data['opening'] as Map<String, dynamic>)
        .map((key, value) {
      final timeString = value as String;

      if (timeString != null && timeString.isNotEmpty) {
        final splitted = timeString.split(RegExp(r"[:-]"));
        return MapEntry(
          key,
          {
            "from": TimeOfDay(
                hour: int.parse(splitted[0]), minute: int.parse(splitted[1])),
            "to": TimeOfDay(
                hour: int.parse(splitted[2]), minute: int.parse(splitted[3])),
          },
        );
      } else {
        return MapEntry(key, null);
      }
    });

    // print("Opening $opening");
  }

  String name;
  String phone;
  String image;
  Address address;
  Map<String, Map<String, TimeOfDay>> opening;

//recupera texto com endereço
  String get addressText =>
      "${address.street}, ${address.number} ${address.complement.isNotEmpty ? ' - ${address.complement}' : ""} " +
      "- ${address.district}, ${address.city}/${address.state}";

//recupera horario de abertura em texto
  String get openingText {
    return "Seg-Sex: ${formattedPeriod(opening['mon_fri'])}\n" +
        "Sab: ${formattedPeriod(opening['saturday'])}\n" +
        "Dom: ${formattedPeriod(opening['sunday'])}";
  }

  //formata periodo de abertura de tempo (recuperando o mapentry linha 18)
  String formattedPeriod(Map<String, TimeOfDay> period) {
    if (period == null) return "Fechada";
    //pegar horario de abertura e fechamento
    return "${period['from'].formattedTime()} - ${period['to'].formattedTime()}";
  }
}
