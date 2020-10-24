import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/address.dart';
import 'package:ravelinestores/helpers/extensions.dart';

enum StoreStatus { closed, open, closing }

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

    updateStatus();
    // print("Opening $opening");
  }

  String name;
  String phone;
  String image;
  Address address;
  Map<String, Map<String, TimeOfDay>> opening;
  StoreStatus status;
  String get cleanPhone => phone.replaceAll(RegExp(r"[^\d]"), "");

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

  void updateStatus() {
    //qual dia da semana
    final weekDay = DateTime.now().weekday;

    Map<String, TimeOfDay> period;
    if (weekDay >= 1 && weekDay >= 5) {
      period = opening['mon_fri'];
    } else if (weekDay == 6) {
      period = opening['saturday'];
    } else {
      period = opening['sunday'];
    }

    final now = TimeOfDay.now();

    if (period == null) {
      status = StoreStatus.closed;
    } else if (period['from'].toMinutes() < now.toMinutes() &&
        period['to'].toMinutes() - 15 > now.toMinutes()) {
      status = StoreStatus.open;
    } else if (period['from'].toMinutes() < now.toMinutes() &&
        period['to'].toMinutes() > now.toMinutes()) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.closed;
    }
  }

  String get statusText {
    switch (status) {
      case StoreStatus.closed:
        return 'Fechada';
        break;
      case StoreStatus.closing:
        return 'Fechando';
        break;
      case StoreStatus.open:
        return 'Aberta';
        break;
      default:
        return '';
    }
  }
}
