class Address {
  Address({
    this.alt,
    this.city,
    this.complement,
    this.district,
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
  String district;
  String number;
  String street;
  String city;
  String state;

  //converte objeto em mapa

  Map<String, dynamic> toMap() {
    return {
      'altitude': alt,
      'latitude': lat,
      'longitude': long,
      'zipCode': zipCode,
      'complement': complement,
      'district': district,
      'number': number,
      'street': street,
      'city': city,
      'state': state,
    };
  }

  //converte mapa em objeto
  Address.fromMap(Map<String, dynamic> map)
      : alt = map['altitude'] as double,
        lat = map['latitude'] as double,
        long = map['longitude'] as double,
        zipCode = map['zipCode'] as String,
        complement = map['complement'] as String,
        district = map['district'] as String,
        number = map['number'] as String,
        street = map['street'] as String,
        city = map['city'] as String,
        state = map['state'] as String;
}
