import 'package:flutter/cupertino.dart';

class Address {
  Address({
    this.alt,
    this.city,
    this.complement,
    this.disctrict,
    this.lat,
    this.long,
    this.number,
    this.state,
    this.zipCode,
    this.street,
  });

  double alt;
  double lat;
  double long;

  String zipCode;
  String complement;
  String disctrict;
  String number;
  String street;
  String city;
  String state;
}
