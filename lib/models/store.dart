import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/address.dart';

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
                hour: int.parse(splitted[0]), minute: int.parse(splitted[0])),
            "to": TimeOfDay(
                hour: int.parse(splitted[2]), minute: int.parse(splitted[3])),
          },
        );
      } else {
        return MapEntry(key, null);
      }
    });

    print("Opening $opening");
  }

  String name;
  String phone;
  String image;
  Address address;
  Map<String, Map> opening;
}
